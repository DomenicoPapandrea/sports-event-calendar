import { prisma } from "@/lib/db";
import { NextRequest, NextResponse } from "next/server";
import { eventErrorHandler } from "../errorHandler";
import { FootballEventResult } from "@prisma/client";

export async function GET(request: NextRequest) {
    try {

        // Get the search params from the URL
        const searchParams = request.nextUrl.searchParams;
        // Build query filters based on parameters
        const filters: any = {};

        //Parameters handling
        const paramMapping: Record<string, (value: string) => any> = {
            date: (value) => new Date(value),
            sport: (value) => value,
            status: (value) => value,
            season: (value) => value,
            home_team_name: (value) => value,
            away_team_name: (value) => value,
            event_result: (value) => value
        };

        for (const [param, converter] of Object.entries(paramMapping)) {
            const value = searchParams.get(param);
            if (value) {
                filters[param] = converter(value);
            }
        }

       //If event_result is present, get the data from the footballEventResult table
       var eventResult : any = {}
       if(filters["event_result"]){
        eventResult = await prisma.footballEventResult.findMany({
            where: { event_id: filters["event_result"] 
            }
        })
       }       

        // Use the filters in the prisma query
        const events = await prisma.event.findMany({
            where: filters
        });

        // Success response with events
        return NextResponse.json({events, ...eventResult}, { status: 200 })
    } catch (error) {
        return eventErrorHandler(error);
    }
}   
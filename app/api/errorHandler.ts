import { Prisma } from "@prisma/client"
import { NextResponse } from "next/server"

export async function  eventErrorHandler(error: any) {
    if (error instanceof Prisma.PrismaClientKnownRequestError) {
        // Common Prisma error codes:
        switch (error.code) {
          case 'P1001':
            // Cannot reach database server
            return NextResponse.json(
              { message: 'Database connection error' },
              { status: 503 }
            )
          case 'P2002':
            // Unique constraint violation
            return NextResponse.json(
              { message: 'Unique constraint violation' },
              { status: 409 }
            )
         /*  case 'P2025':
            // Record not found
            return NextResponse.json(
              { message: 'Record not found' },
              { status: 404 }
            ) */
          default:
            console.error('Prisma error:', error.code, error.message)
            return NextResponse.json(
              { message: 'Database error' },
              { status: 500 }
            )
        }
    }
  
    // For non-Prisma errors
    console.error('Unexpected error:', error)
    return NextResponse.json(
        { message: 'Internal server error' },
        { status: 500 }
    )
}


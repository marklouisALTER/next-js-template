import { Metadata } from "next";
import "../globals.css";

export const metadata: Metadata = {
    title: "Next TS Starter",
    description: "Next.js TypeScript Starter",
}

export default function RootLayout({ children }: { children: React.ReactNode }){
    return(
        <html lang="en">
            <body>
                {children}
            </body>
        </html>
    )
}
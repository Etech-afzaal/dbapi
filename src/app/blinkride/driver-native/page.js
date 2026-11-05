"use client";

import { GatewayApiTest } from "../../elite-postman/page";

export default function DriverNativePage() {

  return (
    <GatewayApiTest
      payloadUrl="/data/brDriverNativeApp/brDriverNativeApp.json"
      heading="BR Driver Native App"
      subheading="BlinkRide DB-Gatekeeper Test client"
    />
  );
}

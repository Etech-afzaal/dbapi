"use client";

import { GatewayApiTest } from "../../elite-postman/page";

export default function CustomerAppPage() {
  return (
    <GatewayApiTest
      payloadUrl="/data/brCustomerApp/brCustomerApp.json"
      heading="BR Customer App"
      subheading="BlinkRide DB-Gatekeeper Test client"
    />
  );
}

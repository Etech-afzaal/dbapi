"use client";

import { GatewayApiTest } from "../../elite-postman/page";

export default function IoWebPortalPage() {
  return (
    <GatewayApiTest
      payloadUrl="/data/brIoWebPortal/brIoWebPortal.json"
      heading="BR IO Web Portal"
      subheading="BlinkRide DB-Gatekeeper Test client"
    />
  );
}

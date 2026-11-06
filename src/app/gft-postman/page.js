"use client";

import { GatewayApiTest } from "../elite-postman/page";

export default function GftPostmanPage() {
  return (
    <GatewayApiTest
      payloadUrl="/data/gftCustomerApp/gftPayload.json"
      heading="GFT Postman"
      subheading="GFT DB-Gatekeeper Test client"
    />
  );
}

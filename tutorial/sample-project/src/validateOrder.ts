import { Order } from "./types";

export type ValidationResult =
  | { ok: true }
  | { ok: false; reason: string };

// Checks that an order is well-formed enough to process.
export function validateOrder(order: Order): ValidationResult {
  if (!order.customerEmail.includes("@")) {
    return { ok: false, reason: "customer email looks invalid" };
  }
  if (order.lines.length === 0) {
    return { ok: false, reason: "order has no lines" };
  }
  return { ok: true };
}

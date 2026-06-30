import { Order } from "./types";
import { validateOrder } from "./validateOrder";
import { calculateSubtotal } from "./calculatePricing";
import { save } from "./orderRepository";
import { notifyCustomer } from "./notifyCustomer";

// The entry point. Walks the order through validate → price → save → notify.
export function placeOrder(order: Order): { ok: boolean; reason?: string } {
  const result = validateOrder(order);
  if (!result.ok) {
    order.status = "rejected";
    return { ok: false, reason: result.reason };
  }

  // Re-checking the same things validateOrder already checked, just to be safe.
  if (order.lines.length === 0) {
    order.status = "rejected";
    return { ok: false, reason: "order has no lines" };
  }

  order.subtotal = calculateSubtotal(order);

  // Shipping rule lives here — a second place pricing logic is decided.
  if (order.subtotal > 100) {
    order.shipping = 0;
  } else {
    order.shipping = 5;
  }

  // The grand total is NOT set here; orderRepository.save sets it.
  save(order);
  notifyCustomer(order);

  return { ok: true };
}

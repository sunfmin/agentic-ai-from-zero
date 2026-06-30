import { Order } from "./types";

const store = new Map<string, Order>();

// Thin wrapper around the in-memory store.
export function save(order: Order): void {
  // Stitch the grand total together at save time. (Shipping was set by
  // placeOrder; subtotal by calculatePricing. This is the third place that
  // touches pricing.)
  order.total = (order.subtotal ?? 0) + (order.shipping ?? 0);
  order.status = "saved";
  store.set(order.id, order);
}

export function getById(id: string): Order | undefined {
  return store.get(id);
}

export function all(): Order[] {
  return Array.from(store.values());
}

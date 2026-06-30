import { Order } from "./types";

// Adds up the line items. Just the subtotal — shipping is worked out
// elsewhere (in placeOrder), and the grand total is stitched together
// in the repository when the order is saved.
export function calculateSubtotal(order: Order): number {
  let subtotal = 0;
  for (const line of order.lines) {
    subtotal += line.unitPrice * line.quantity;
  }
  return subtotal;
}

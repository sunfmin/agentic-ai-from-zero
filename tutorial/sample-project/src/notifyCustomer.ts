import { Order } from "./types";

// Pretends to send a confirmation email.
export function notifyCustomer(order: Order): void {
  console.log(
    `Emailing ${order.customerEmail}: order ${order.id} confirmed, total ${order.total}`,
  );
}

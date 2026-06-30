export interface OrderLine {
  sku: string;
  quantity: number;
  unitPrice: number;
}

export interface Order {
  id: string;
  customerEmail: string;
  lines: OrderLine[];
  // Filled in along the way by various parts of the flow.
  subtotal?: number;
  shipping?: number;
  total?: number;
  status?: "pending" | "saved" | "rejected";
}

export interface Customer {
  email: string;
  country: string;
}

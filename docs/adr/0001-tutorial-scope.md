# Tutorial scope: macOS only, readers assumed to have international payment + network access

The tutorial targets readers on **macOS only**, and assumes they already have **stable access to anthropic.com and an international credit card**. We are explicitly *not* covering Windows / WSL2, Linux, or mainland-China network and payment workarounds.

## Why

The tutorial's promise is "from zero to writing a multi-file Claude Code skill" for an absolute beginner. Each branch we'd add would dwarf the tutorial itself:

- **Windows / WSL2** would require teaching readers to install Linux-inside-Windows before they can even open a terminal — a separate book.
- **Mainland-China network workarounds** (which VPN, which nodes, how to acquire a foreign credit card) are far outside the scope of a Claude Code tutorial, carry compliance risk, and are an open-ended rabbit hole the tutorial cannot credibly maintain.

Cutting these lets the main path stay short, concrete, and verifiable on the maintainer's own machine.

## Consequences

- The tutorial declares its prerequisites explicitly in chapter 0 ("a Mac; can reach google.com; has a Visa/Mastercard"). Readers who don't meet them are turned away at the door, not stuck in chapter 2.
- A "Windows companion" or "mainland network notes" could be added as a separate volume later without changing the main tutorial.

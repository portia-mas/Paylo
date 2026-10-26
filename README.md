# Paylo - Every Payment Builds Your Proof

**Paylo** is an offline-first digital till designed to help township and rural traders record everyday business transactions and build a more organised record of their business activity.

Paylo aims to help small traders turn daily sales into useful business records that can support their journey towards financial inclusion.

> Every payment builds your proof.

## The Problem

Many informal traders operate without a consistent, accessible way to record their sales and expenses. Without organised business records, it can be harder to demonstrate business activity when seeking financial services or opportunities.

## The Solution

Paylo provides a simple digital till experience that helps traders record sales, maintain business records and explore ways to grow their businesses.

The application is designed around accessibility, straightforward recordkeeping and future opportunities for financial inclusion.

## Features

### Sell
- Record sales through a simple product-selection interface.
- Record cash sales and other supported payment methods.
- Designed for a straightforward, mobile-friendly selling experience.

### Records
- View recorded sales and expenses.
- Review transaction amounts, payment methods and synchronisation statuses.
- Store transaction records in the connected Supabase database when synchronisation succeeds.

### Passport
- A space for organising business information and supporting a more structured picture of business activity.

### Grow
- A dedicated section for business growth and financial inclusion features.

### Safe
- A dedicated section for safety-related features and information.

*Feature availability depends on the functionality implemented in the current application version.*

## Technology Stack

- **Frontend:** HTML, CSS and JavaScript
- **Database and backend services:** Supabase
- **Database:** PostgreSQL
- **Authentication:** Supabase Auth, where configured
- **Security:** Supabase Row Level Security (RLS), database policies and Web Crypto-related functionality
- **QR functionality:** QRCodeJS
- **Deployment:** Vercel

## Project Structure

```text
paylo/
├── index.html
├── supabase.sql
└── README.md
```

This is the expected core structure. Keep any additional assets or files required by your actual application.

## Getting Started

### 1. Prerequisites

You will need:

- Git
- A GitHub account
- A Supabase account
- A modern web browser
- A Vercel account for deployment

### 2. Set Up Supabase

1. Create or open your Supabase project.
2. Open the SQL Editor in your project dashboard.
3. Review and run the provided `supabase.sql` script.
4. Confirm that the required database tables and Row Level Security policies exist.
5. Configure authentication according to the application's login flow.

### 3. Configure the Application

Open `index.html` and locate the Supabase configuration.

```javascript
const CFG = {
  url: 'YOUR_SUPABASE_PROJECT_URL',
  key: 'YOUR_SUPABASE_PUBLISHABLE_KEY'
};
```

Replace the placeholders with your actual Supabase Project URL and publishable key.

**Security:** Never place an `sb_secret_...` key or a `service_role` key in frontend code. Keep secret credentials out of GitHub. Database security must be enforced through appropriate authentication and RLS policies.

### 4. Run Locally

Open `index.html` in your browser or serve the folder using a local development server.

Test the login flow, record a transaction and verify that the expected data appears in Supabase.

Some browser features may work differently when opening an HTML file directly, so use a local development server if necessary.

## Deploying to Vercel

1. Push the project to a GitHub repository.
2. Sign in to Vercel.
3. Import the Paylo repository.
4. Configure the project as a static site if the repository contains only HTML, CSS and JavaScript.
5. Set the output directory to the location containing `index.html`.
6. Deploy and test the live application.

After deployment, verify authentication, transaction recording, database synchronisation and the behaviour of each application section.

## Security and Limitations

- Supabase credentials must be configured safely.
- RLS policies should prevent users from accessing other users' private business records.
- Client-side checks alone do not provide authoritative payment verification.
- QR, payment-link, FNB, SMS, WhatsApp, USSD and banking integrations must be treated as simulated wherever they have not been connected to real providers.
- A transaction marked as synchronised should be verified against the database when testing.
- Cryptographic signing in the browser does not, by itself, establish that a payment was genuinely received.
- Paylo should not be presented as guaranteeing credit approval, bank acceptance or financial outcomes.

## Vision

Paylo aims to make everyday business recordkeeping more accessible to informal traders, helping them build organised records of their activity and explore opportunities to grow.

## Project Status

**Status:** Hackathon prototype in development.

Paylo is being developed as a prototype. Features, integrations and security controls should be validated before use with real business or financial data.

## Acknowledgements

Developed for the FNB App of the Year Hackathon 2026.

**Paylo — Every Payment Builds Your Proof.**



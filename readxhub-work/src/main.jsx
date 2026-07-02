import React from "react";
import ReactDOM from "react-dom/client";
import "./index.css";
import App from "./App";
import reportWebVitals from "./reportWebVitals";
import { Auth0Provider } from "@auth0/auth0-react";
import AuthProvider from "./AuthProvider";
import { HelmetProvider } from "react-helmet-async";

const root = ReactDOM.createRoot(document.getElementById("root"));

const onRedirectCallback = (appState) => {
  const returnTo = appState?.returnTo || window.location.pathname + window.location.search;
  window.location.replace(returnTo);
};

root.render(
  <Auth0Provider
    domain="dev-2tch1sa06fpsglz6.us.auth0.com"
    clientId="TAFccewwCi2t5fiNUNqyeF9ZS2hEP4r4"
    authorizationParams={{
      redirect_uri: window.location.origin,
      // 🔑 THIS IS THE KEY
      scope: "openid profile email offline_access",
    }}
    onRedirectCallback={onRedirectCallback}
    cacheLocation="localstorage"
    useRefreshTokens={true}
  >
    <AuthProvider>
      <HelmetProvider>
        <App />
      </HelmetProvider>
    </AuthProvider>
  </Auth0Provider>
);

reportWebVitals();

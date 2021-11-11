import React from "react";
import { Container } from "semantic-ui-react";
import Head from "next/head";
import Header from "./Header";

const Layout = (props) => {
  return (
    <Container>
      <Head>
        <link
          rel="stylesheet"
          href="//cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.4.1/semantic.min.css"
        ></link>
      </Head>
      <Header />
      {props.children}
      <footer
        style={{
          backgroundColor: "#DDDEDE",
          position: "fixed",
          width: "100%",
          left: 0,
          bottom: 0,
          textAlign: "center",
          overflow: "auto",
        }}
      >
        &copy; ZrinCin, 2021.
      </footer>
    </Container>
  );
};
export default Layout;

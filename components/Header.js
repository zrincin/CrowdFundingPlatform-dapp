import React from "react";
import { Menu, Icon } from "semantic-ui-react";
import { Link } from "../routes";

const Header = () => {
  return (
    <Menu style={{ marginTop: "10px" }}>
      <Link route="/">
        <a className="item"><Icon name="home"/><b>Campaigns</b></a>
      </Link>
      <Menu.Menu>
        <Link route="/campaigns/new">
          <a className="item"><Icon name="plus"/></a>
        </Link>
      </Menu.Menu>
    </Menu>
  );
};

export default Header;

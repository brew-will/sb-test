import React from 'react';

const Button = ({ borderColour = 'black', children }) => {
  return <button style={{ border: `solid 1px ${borderColour}` }}>{children}</button>;
};

export default Button;

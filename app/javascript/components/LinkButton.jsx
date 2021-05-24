import React from 'react';
import PropTypes from 'prop-types';

const LinkButton = ({
  buttonClass,
  icon,
  link,
  text,
}) => (
  <a href={link}>
    <button type="button" className={`btn ${buttonClass}`}>
      <span className={`icon ${icon}`} />
      {text}
    </button>
  </a>
);

LinkButton.propTypes = {
  buttonClass: PropTypes.string,
  icon: PropTypes.string,
  link: PropTypes.string,
  text: PropTypes.string,
};

LinkButton.defaultProps = {
  buttonClass: '',
  icon: '',
  link: '',
  text: '',
};

export default LinkButton;

import React, { Component } from "react";
import axios from "axios";

export default class CreateCampaign extends Component {
  getPath(company, isClient) {
    if (isClient) {
      return `/agencies/${company.agency_id}/clients/${company.id}/campaigns`;
    } else {
      return `/advertisers/${company.id}/campaigns`;
    }
  }

  sendCampaign = (props) => {
    event.preventDefault();
    const { company, isClient, stateProps, setErrorMessages } = props;
    const campaignPath = this.getPath(company, isClient);
    const { audiences, errors, ...campaign } = stateProps;

    axios
      .post(campaignPath, {
        campaign: campaign,
        audience: { ids: audiences },
        request_type: { type: event.target.value },
      })
      .then((response) => {
        let errors = stateProps.errors;

        const { messages, redirectTo, status } = response.data;

        if (status === 422) {
          {
            Object.entries(messages).map(
              ([key, value]) => (errors[key] = value)
            );
          }
          setErrorMessages(errors);
        } else {
          window.location.assign(redirectTo);
        }
      });
  };

  render() {
    const { company, isClient } = this.props;

    return (
      <div className="col col-12 d-flex submit-btns">
        <a className="mr-auto p-2" href={this.getPath(company, isClient)}>
          Cancel
        </a>
        <button
          className="btn btn-primary p-2 io-btn"
          onClick={(event) => this.sendCampaign(this.props)}
          value={"insertion_order"}
        >
          Request IO
        </button>
        <button
          className="btn btn-primary p-2 recommedation-btn"
          onClick={(event) => this.sendCampaign(this.props)}
          value={"recommendation"}
        >
          Request Recommendations
        </button>
      </div>
    );
  }
}
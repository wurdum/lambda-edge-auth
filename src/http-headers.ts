// Copyright 2019 Amazon.com, Inc. or its affiliates. All Rights Reserved.
// SPDX-License-Identifier: MIT-0

import { CloudFrontResponseHandler } from "aws-lambda";
import { getConfig, Config } from "./shared";

let CONFIG: Config;

export const handler: CloudFrontResponseHandler = async (event) => {
  if (!CONFIG) {
    CONFIG = await getConfig();
    CONFIG.logger.debug("Configuration loaded:", CONFIG);
  }
  CONFIG.logger.debug("Event:", event);
  const response = event.Records[0].cf.response;
  Object.assign(response.headers, CONFIG.cloudFrontHeaders);
  CONFIG.logger.debug("Returning response:\n", response);
  return response;
};

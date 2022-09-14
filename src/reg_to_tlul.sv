// Copyright 2022 OpenHW Group
// Solderpad Hardware License, Version 2.1, see LICENSE.md for details.
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1

/**
 * Reg Interface to Tile-Link
 */

module reg_to_tlul #(
  parameter type req_t = logic,
  parameter type rsp_t = logic,
  parameter type tl_h2d_t = logic,
  parameter type tl_d2h_t = logic
) (
    // TL-UL interface
    output tl_h2d_t tl_o,
    input  tl_d2h_t tl_i,

    // Register interface
    input  req_t reg_req_i,
    output rsp_t reg_rsp_o
);


  assign tl_o.a_valid    = reg_req_i.valid & tl_i.a_ready;
  assign tl_o.a_opcode   = reg_req_i.write ? PutFullData : Get;
  assign tl_o.a_param    = '0;
  assign tl_o.a_size     = 'h2;
  assign tl_o.a_source   = '0;
  assign tl_o.a_address  = reg_req_i.addr;
  assign tl_o.a_mask     = reg_req_i.wstrb;
  assign tl_o.a_data     = reg_req_i.wdata;
  assign tl_o.a_user     = tlul_pkg::TL_A_USER_DEFAULT;
  assign tl_o.d_ready    = 1'b1;

  assign reg_rsp_o.ready = tl_i.d_valid & tl_o.d_ready;
  assign reg_rsp_o.rdata = tl_i.d_data;
  assign reg_rsp_o.error = tl_i.d_error;


endmodule

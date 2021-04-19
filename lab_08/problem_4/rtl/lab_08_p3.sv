/* lab_08_p3.sv */

module lab_08_p3 (
input logic [31:0] imm,rs1_data,rs2_data,
input   logic  [6:0] opcode,

input   logic  [3:0] funct, // alu veya branch ops

output logic  [31:0] sonuc, //rd_data veya new pc

output logic         pc_update,we,hata// branch basarili ise pc enable

);
//opcode
parameter R = 7'b0000001;
parameter I = 7'b0000011;
parameter U = 7'b0000111;
parameter B = 7'b0001111;

always_comb begin
    case(opcode)
//////////////////////////////////////////////////////////////////////////////////////
            R:
            begin
            //add
            if(funct == 4'b0) begin
            sonuc = $signed(rs1_data) + $signed(rs2_data);
            hata = 0;
            pc_update = 0;
            we = 1;
            end
            //sub
            else if(funct == 4'b1000) begin
            sonuc = $signed(rs1_data) - $signed(rs2_data);
            hata = 0;
            pc_update = 0;
            we = 1;
            end
            //and
            else if(funct == 4'b0111) begin
            sonuc = $signed(rs1_data) && $signed(rs2_data);
            hata = 0;
            pc_update = 0;
            we = 1;
            end
            //or
            else if(funct == 4'b0110) begin
            sonuc = $signed(rs1_data) || $signed(rs2_data);
            hata = 0;
            pc_update = 0;
            we = 1;
            end
            //eor
            else if(funct == 4'b0100) begin
            sonuc = $signed(rs1_data) ^ $signed(rs2_data);
            hata = 0;
            pc_update = 0;
            we = 1;
            end
            //lsl
            else if(funct == 4'b0001) begin
            sonuc = rs1_data << rs2_data;
            hata = 0;
            pc_update = 0;
            we = 1;
            end
            //lsr
            else if(funct == 4'b0101) begin
            sonuc = $signed(rs1_data) >> $signed(rs2_data);
            hata = 0;
            pc_update = 0;
            we = 1;
            end
            //asr
            else if(funct == 4'b1101) begin
            sonuc = $signed(rs1_data) >>> $signed(rs2_data);
            hata = 0;
            pc_update = 0;
            we = 1;
            end
            // hata
            else begin
            sonuc = 32'bx;
            hata = 1'bx;
            pc_update = 1'bx;
            we = 1'bx;
            end

            end
//////////////////////////////////////////////////////////////////////////////////////
            I:
            begin

            //addi
            if(funct == 4'b0) begin
            sonuc = $signed(rs1_data) + $signed(imm);
            hata = 0;
            pc_update = 0;
            we = 1;
            end
            //andi
            else if(funct == 4'b0111) begin
            sonuc = $signed(rs1_data) & $signed(imm);
            hata = 0;
            pc_update = 0;
            we = 1;
            end
            //ori
            else if(funct == 4'b0110) begin
            sonuc = $signed(rs1_data) | $signed(imm);
            hata = 0;
            pc_update = 0;
            we = 1;
            end
            //eorı
            else if(funct == 4'b0100) begin
            sonuc = $signed(rs1_data) ^ $signed(imm);
            hata = 0;
            pc_update = 0;
            we = 1;
            end
            //lsli
            else if(funct == 4'b0001) begin
            sonuc = rs1_data << imm;
            hata = 0;
            pc_update = 0;
            we = 1;
            end
            //lsri
            else if(funct == 4'b0101) begin
            sonuc = rs1_data >> imm;
            hata = 0;
            pc_update = 0;
            we = 1;
            end
            else begin
            sonuc = 32'bx;
            hata = 1;
            pc_update = 0;
            we = 0;
            end
            end
//////////////////////////////////////////////////////////////////////////////////////
            U:
            // mov
            begin
            sonuc = imm;
            hata = 0;
            pc_update = 0;
            we = 1;
            end
//////////////////////////////////////////////////////////////////////////////////////
            B:
            begin
            //b
            if(funct == 4'b0011)begin
            pc_update = 1;
            sonuc = $signed(imm);
            hata = 0;
            we = 0;
            end
            //beq
            else if(funct == 4'b0000) begin
                if($signed(rs1_data) == $signed(rs2_data)) begin
                pc_update = 1;
                sonuc = $signed(imm);
                hata = 0;
                we = 0;
                end
                else begin
                pc_update = 0;
                sonuc = 32'bx;
                hata = 0;
                we = 0;
                end
            end
            //bne
            else if(funct == 4'b0001) begin
                if($signed(rs1_data) != $signed(rs2_data)) begin
                pc_update = 1;
                sonuc = $signed(imm);
                hata = 0;
                we = 0;
                end
                else begin
                pc_update = 0;
                sonuc = 32'bx;
                hata = 0;
                we = 0;
                end
            end
            //blt
            else if(funct == 4'b0100) begin
                if($signed(rs1_data) < $signed(rs2_data)) begin
                pc_update = 1;
                sonuc = $signed(imm);
                hata = 0;
                we = 0;
                end
                else begin
                pc_update = 0;
                sonuc = 32'bx;
                hata = 0;
                we = 0;
                end
            end
            //bge
            else if(funct == 4'b0101) begin
                if($signed(rs1_data) >= $signed(rs2_data)) begin
                pc_update = 1;
                sonuc = $signed(imm);
                hata = 0;
                we = 0;
                end
                else begin
                pc_update = 0;
                sonuc = 32'bx;
                hata = 0;
                we = 0;
                end
            end
            //bltu
            else if(funct == 4'b0110) begin
                if(rs1_data < rs2_data) begin
                pc_update = 1;
                sonuc = imm;
                hata = 0;
                we = 0;
                end
                else begin
                pc_update = 0;
                sonuc = 32'bx;
                hata = 0;
                we = 0;
                end
            end
            //bgeu
            else if(funct == 4'b0111) begin
                if(rs1_data >= rs2_data) begin
                pc_update = 1;
                sonuc = imm;
                hata = 0;
                we = 0;
                end
                else begin
                pc_update = 0;
                sonuc = 32'bx;
                hata = 0;
                we = 0;
                end
            end
            //hata
            else begin
            pc_update = 0;
            sonuc = 32'bx;
            hata = 1;
            we = 0;
            end
            end
            default: begin
            pc_update = 0;
            sonuc = 32'bx;
            hata = 1;
            we = 0;
            end
            endcase
end
endmodule

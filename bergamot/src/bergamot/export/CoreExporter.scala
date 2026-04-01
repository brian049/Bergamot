package bergamot.exporter

import chisel3._
// _root_ disambiguates from package chisel3.util.circt if user imports chisel3.util._
import _root_.circt.stage.ChiselStage

import bergamot.core._

object conf {
  val firtoolOptions = Array(
    "--lowering-options=" + List(
      // make yosys happy
      // see https://github.com/llvm/circt/blob/main/docs/VerilogGeneration.md
      "disallowLocalVariables",
      // "disallowPackedArrays",
      "locationInfoStyle=wrapInAtSquareBracket"
    ).reduce(_ + "," + _)
  )
}

object CoreExporter extends App {
  circt.stage.ChiselStage.emitSystemVerilogFile(new BergamotCore(CoreConfig.default), args, conf.firtoolOptions)
}

object CoreExporterSim extends App {
  circt.stage.ChiselStage.emitSystemVerilogFile(new VerilatorTestCore(), args, conf.firtoolOptions)
}

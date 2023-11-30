import { fail } from "k6"
import avro from "k6/x/avrogen"

let file = open('./schema.json')
const tnt_schema = JSON.parse(file)
const keys = [
  "agreement",
  "agreementSpecification",
  "validFor",
  "startDateTime"
]


export function setup() {
  let schema = avro.PrepareSchema(tnt_schema)
  let avro_schema = avro.New(schema)
  let avro_obj = avro_schema.generateValue()

  keys.forEach((k) => {
    avro_obj = avro_obj[k]
  })
  if (avro_obj != "string") {
    fail("Broken object")
  }
}

export default function () { }

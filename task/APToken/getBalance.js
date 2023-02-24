/*******************************************************************************
 *   (c) 2022 Zondax AG
 *
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 ********************************************************************************/
//
// DRAFT!! THIS CODE HAS NOT BEEN AUDITED - USE ONLY FOR PROTOTYPING
//
const util = require("util")
const request = util.promisify(require("request"))

task("GetBalance", "MintWithCondition for user")
    .addParam("contractaddress", "The SimpleCoin address")
    .addParam("user", "which id would you want")
    .setAction(async (taskArgs) => {
        const contractAddr = taskArgs.contractaddress
        const user = taskArgs.user
        const amount = taskArgs.amount
        const point = taskArgs.point
        const networkId = network.name
        const SimpleCoin = await ethers.getContractFactory("APToken")
        //Get signer information
        const accounts = await ethers.getSigners()
        const signer = accounts[0]
        const priorityFee = await callRpc("eth_maxPriorityFeePerGas")


        async function callRpc(method, params) {
            var options = {
                method: "POST",
                url: network.config.url,
                headers: {
                    "Content-Type": "application/json",
                },
                body: JSON.stringify({
                    jsonrpc: "2.0",
                    method: method,
                    params: params,
                    id: 1,
                }),
            }
            const res = await request(options)
            return JSON.parse(res.body).result
        }

        const simpleCoinContract = new ethers.Contract(contractAddr, SimpleCoin.interface, signer)

        let result = BigInt(await simpleCoinContract.balanceOf(user)).toString()
        console.log("address :",user, " balance is:",result)

        //get balance 
        // const balance  = await callRpc("Filecoin.EthGetBalance", [contractAddr,"latest"])
        // console.log("EthGetBalance:",contractAddr," balance:",balance)
    })

module.exports = {}

module("modules.logic.nfc.rpc.NFCRpc", package.seeall)

slot0 = class("NFCRpc", BaseRpc)
slot0.instance = slot0.New()

return slot0

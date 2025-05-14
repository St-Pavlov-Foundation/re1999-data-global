module("modules.logic.nfc.config.NFCConfig", package.seeall)

local var_0_0 = class("NFCConfig", BaseConfig)

function var_0_0.reqConfigNames(arg_1_0)
	return {
		"nfc_recognize"
	}
end

function var_0_0.onInit(arg_2_0)
	return
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "nfc_recognize" then
		arg_3_0._nfcRecognizeConfig = arg_3_2
	end
end

function var_0_0.getNFCRecognizeCo(arg_4_0, arg_4_1)
	return arg_4_0._nfcRecognizeConfig.configDict[arg_4_1]
end

var_0_0.instance = var_0_0.New()

return var_0_0

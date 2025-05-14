module("modules.logic.optionpackage.adapter.OptionPackageBaseAdapter", package.seeall)

local var_0_0 = class("OptionPackageBaseAdapter")

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.setDownloder(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._downloader = arg_2_1
	arg_2_0._httpWorker = arg_2_2
end

function var_0_0.getHttpGetterList(arg_3_0)
	logError("[OptionPackageBaseAdapter:getHttpGetterList()]子类及派生类重新该接口")
end

function var_0_0.getDownloadList(arg_4_0)
	logError("[OptionPackageBaseAdapter:getHttpGetterList()]子类及派生类重新该接口")
end

function var_0_0.getDownloadUrl(arg_5_0, arg_5_1)
	if arg_5_0._httpWorker then
		return arg_5_0._httpWorker:getDownloadUrl(arg_5_1)
	end
end

function var_0_0.onDownloadStart(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	return
end

function var_0_0.onDownloadProgressRefresh(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	return
end

function var_0_0.onDownloadPackSuccess(arg_8_0, arg_8_1)
	return
end

function var_0_0.onDownloadPackFail(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	return
end

function var_0_0.onNotEnoughDiskSpace(arg_10_0, arg_10_1)
	return
end

function var_0_0.onUnzipProgress(arg_11_0, arg_11_1)
	return
end

function var_0_0.onPackUnZipFail(arg_12_0, arg_12_1, arg_12_2)
	return
end

function var_0_0.onPackItemStateChange(arg_13_0, arg_13_1)
	return
end

return var_0_0

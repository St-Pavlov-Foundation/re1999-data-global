module("projbooter.hotupdate.optionpackage.OptionPackageHttpWorker", package.seeall)

local var_0_0 = class("OptionPackageHttpWorker")

function var_0_0.ctor(arg_1_0)
	arg_1_0._httpGetterList = {}
	arg_1_0._httpGetterFinishDict = {}
	arg_1_0._httpResultDict = {}
end

function var_0_0.start(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	if not arg_2_1 or #arg_2_1 < 1 then
		arg_2_0:_runCallBack(arg_2_2, arg_2_3)

		return
	end

	arg_2_0._httpGetterList = {}

	tabletool.addValues(arg_2_0._httpGetterList, arg_2_1)
	arg_2_0:_httpGetterStart(arg_2_2, arg_2_3)
end

function var_0_0.stop(arg_3_0)
	for iter_3_0, iter_3_1 in pairs(arg_3_0._httpGetterList) do
		if not arg_3_0._httpGetterFinishDict[iter_3_1:getHttpId()] then
			iter_3_1:stop()
		end
	end
end

function var_0_0.checkWorkDone(arg_4_0)
	return arg_4_0:_checkHttpGetResult()
end

function var_0_0.againGetHttp(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0._httpGetterOnFinshFunc = arg_5_1
	arg_5_0._httpGetterOnFinshObj = arg_5_2

	for iter_5_0, iter_5_1 in pairs(arg_5_0._httpGetterList) do
		if not arg_5_0._httpGetterFinishDict[iter_5_1:getHttpId()] then
			iter_5_1:start(arg_5_0._onHttpGetterFinish, arg_5_0)
		end
	end
end

function var_0_0.getHttpResult(arg_6_0)
	if not arg_6_0._httpResultDict then
		arg_6_0:_updateHttpResult()
	end

	return arg_6_0._httpResultDict
end

function var_0_0.getPackInfo(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0:getHttpResult()

	if var_7_0 then
		return var_7_0[arg_7_1]
	end
end

function var_0_0.getDownloadUrl(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0:getPackInfo(arg_8_1)

	if var_8_0 then
		return var_8_0.download_url, var_8_0.download_url_bak
	end
end

function var_0_0.getPackSize(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0:getPackInfo(arg_9_1)
	local var_9_1 = 0

	if var_9_0 and var_9_0.res then
		for iter_9_0, iter_9_1 in ipairs(var_9_0.res) do
			var_9_1 = var_9_1 + iter_9_1.length
		end
	end

	return var_9_1
end

function var_0_0._httpGetterStart(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0._httpGetterOnFinshFunc = arg_10_1
	arg_10_0._httpGetterOnFinshObj = arg_10_2
	arg_10_0._httpGetterFinishDict = {}
	arg_10_0._httpResultDict = {}

	for iter_10_0, iter_10_1 in pairs(arg_10_0._httpGetterList) do
		iter_10_1:start(arg_10_0._onHttpGetterFinish, arg_10_0)
	end
end

function var_0_0._onHttpGetterFinish(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0._httpGetterFinishDict[arg_11_2:getHttpId()] = arg_11_1

	if arg_11_1 then
		arg_11_0:_updateHttpResult()
	end

	local var_11_0, var_11_1 = arg_11_0:_checkHttpGetResult()

	if var_11_0 then
		local var_11_2 = arg_11_0._httpGetterOnFinshFunc
		local var_11_3 = arg_11_0._httpGetterOnFinshObj

		arg_11_0._httpGetterOnFinshFunc = nil
		arg_11_0._httpGetterOnFinshObj = nil

		arg_11_0:_runCallBack(var_11_2, var_11_3, var_11_1)
	end
end

function var_0_0._runCallBack(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	if arg_12_1 then
		if arg_12_2 ~= nil then
			arg_12_1(arg_12_2, arg_12_3)
		else
			arg_12_1(arg_12_3)
		end
	end
end

function var_0_0._updateHttpResult(arg_13_0)
	local var_13_0 = {}

	for iter_13_0, iter_13_1 in pairs(arg_13_0._httpGetterList) do
		if arg_13_0._httpGetterFinishDict[iter_13_1:getHttpId()] then
			local var_13_1 = iter_13_1:getHttpResult()

			if var_13_1 then
				for iter_13_2, iter_13_3 in pairs(var_13_1) do
					var_13_0[iter_13_2] = iter_13_3
				end
			end
		end
	end

	arg_13_0._httpResultDict = var_13_0
end

function var_0_0._checkHttpGetResult(arg_14_0)
	local var_14_0 = true
	local var_14_1 = true

	for iter_14_0, iter_14_1 in pairs(arg_14_0._httpGetterList) do
		local var_14_2 = arg_14_0._httpGetterFinishDict[iter_14_1:getHttpId()]

		if var_14_2 == nil then
			var_14_0 = false
			var_14_1 = false

			break
		elseif var_14_2 == false then
			var_14_1 = false
		end
	end

	return var_14_0, var_14_1
end

return var_0_0

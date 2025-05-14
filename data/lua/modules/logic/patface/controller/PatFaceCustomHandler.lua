module("modules.logic.patface.controller.PatFaceCustomHandler", package.seeall)

local var_0_0 = {
	activity142CheckCanPat = function(arg_1_0)
		local var_1_0 = false

		if Activity136Model.instance:isActivity136InOpen() then
			var_1_0 = not Activity136Model.instance:hasReceivedCharacter()
		end

		return var_1_0
	end,
	decalogPresentCheckCanPat = function(arg_2_0)
		return DecalogPresentModel.instance:isShowRedDot()
	end,
	goldenMilletPresentCheckCanPat = function(arg_3_0)
		return GoldenMilletPresentModel.instance:isShowRedDot()
	end,
	matildaGiftCheckCanPat = function(arg_4_0)
		return V1a9_MatildaGiftModel.instance:isShowRedDot()
	end,
	semmelWeisGiftCheckCanPat = function(arg_5_0)
		return SemmelWeisGiftModel.instance:isShowRedDot()
	end,
	bPSPViewCanPat = function(arg_6_0)
		if BpModel.instance:isEnd() then
			return false
		end

		local var_6_0 = BpConfig.instance:getBpCO(BpModel.instance.id)

		if not var_6_0 or not var_6_0.isSp then
			return false
		end

		if ActivityHelper.getActivityStatus(VersionActivity2_2Enum.ActivityId.BPSP, true) ~= ActivityEnum.ActivityStatus.Normal then
			return false
		end

		return BpModel.instance.firstShowSp
	end,
	bPViewCanPat = function(arg_7_0)
		if BpModel.instance:isEnd() then
			return false
		end

		local var_7_0 = string.format("%s#%s#%s", PlayerPrefsKey.FirstShowPatFace, "BPFace", PlayerModel.instance:getPlayinfo().userId)
		local var_7_1 = PlayerPrefsHelper.getString(var_7_0, "")

		return BpModel.instance.firstShow and tonumber(var_7_1) ~= BpModel.instance.id
	end
}

function var_0_0.limitDecorateCanPat(arg_8_0)
	if ActivityHelper.getActivityStatus(VersionActivity2_2Enum.ActivityId.LimitDecorate, true) == ActivityEnum.ActivityStatus.Normal then
		return (var_0_0.checkIsFistShow(arg_8_0))
	end
end

function var_0_0.decalogPresentPat(arg_9_0)
	local var_9_0 = PatFaceConfig.instance:getPatFaceViewName(arg_9_0)

	DecalogPresentController.instance:openDecalogPresentView(var_9_0)
end

function var_0_0.goldenMilletPresentPat(arg_10_0)
	GoldenMilletPresentController.instance:openGoldenMilletPresentView()
end

function var_0_0.matildaGiftPat(arg_11_0)
	V1a9_MatildaGiftController.instance:openMatildaGiftView()
end

function var_0_0.semmelWeisGiftPat(arg_12_0)
	SemmelWeisGiftController.instance:openSemmelWeisGiftView()
end

function var_0_0.checkIsFistShow(arg_13_0)
	local var_13_0 = string.format("%s#%s#%s", PlayerPrefsKey.FirstShowPatFace, arg_13_0, PlayerModel.instance:getPlayinfo().userId)
	local var_13_1 = PlayerPrefsHelper.getString(var_13_0, "")

	return string.nilorempty(var_13_1)
end

function var_0_0.setHasShow(arg_14_0)
	local var_14_0 = string.format("%s#%s#%s", PlayerPrefsKey.FirstShowPatFace, arg_14_0, PlayerModel.instance:getPlayinfo().userId)

	PlayerPrefsHelper.setString(var_14_0, "hasEnter")
end

return var_0_0

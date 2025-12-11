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

function var_0_0.V2a8_WuErLiXiGiftCheckCanPat(arg_15_0)
	return V2a8_WuErLiXiGiftModel.instance:isShowRedDot()
end

function var_0_0.V2a8_WuErLiXiGiftPat(arg_16_0)
	V2a8_WuErLiXiGiftController.instance:openV2a8_WuErLiXiGiftView()
end

function var_0_0.V2a8_SelfSelectCharacterViewCheckCanPat(arg_17_0)
	return Activity199Model.instance:isShowRedDot()
end

function var_0_0.V2a8_SelfSelectCharacterViewPat(arg_18_0)
	Activity199Controller.instance:openV2a8_SelfSelectCharacterView()
end

function var_0_0.V2a8_BPSkinFaceViewCanPat(arg_19_0)
	local var_19_0 = BpModel.instance.payStatus

	if var_19_0 ~= BpEnum.PayStatus.Pay1 and var_19_0 ~= BpEnum.PayStatus.Pay2 then
		return false
	end

	local var_19_1 = CommonConfig.instance:getConstNum(ConstEnum.BPSkinFaceViewSkinId)

	if not var_19_1 or var_19_1 == 0 or not lua_skin.configDict[var_19_1] then
		return false
	end

	if BpController.instance:isEmptySkinFaceViewStr(var_19_1) then
		local var_19_2 = StoreClothesGoodsItemListModel.instance:findMOByProduct(MaterialEnum.MaterialType.HeroSkin, var_19_1)

		if var_19_2 and not var_19_2:alreadyHas() then
			return true
		end
	end

	return false
end

function var_0_0.V2a8_openBPSkinFaceViewPat()
	local var_20_0 = CommonConfig.instance:getConstNum(ConstEnum.BPSkinFaceViewSkinId)

	if var_20_0 ~= 0 then
		ViewMgr.instance:openView(ViewName.BPSkinFaceView, {
			skinId = var_20_0
		})
	end
end

function var_0_0.PowerMakerPatFaceViewCanPat(arg_21_0)
	local var_21_0 = ItemPowerModel.instance:getPowerMakerInfo()

	if not var_21_0 or var_21_0.makeCount <= 0 then
		return
	end

	local var_21_1 = CommonConfig.instance:getConstStr(ConstEnum.PowerMakerPatFaceTime)

	if not string.nilorempty(var_21_1) and TimeUtil.secondToHMS(var_21_0.logoutSecond) >= tonumber(var_21_1) then
		return true
	end
end

function var_0_0.PowerMakerPatFaceViewPat()
	ViewMgr.instance:openView(ViewName.PowerMakerPatFaceView)
end

return var_0_0

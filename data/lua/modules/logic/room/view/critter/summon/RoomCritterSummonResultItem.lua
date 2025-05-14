module("modules.logic.room.view.critter.summon.RoomCritterSummonResultItem", package.seeall)

local var_0_0 = class("RoomCritterSummonResultItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goegg = gohelper.findChild(arg_1_0.viewGO, "#go_egg")
	arg_1_0._gocritter = gohelper.findChild(arg_1_0.viewGO, "#go_critter")
	arg_1_0._imagequality = gohelper.findChildImage(arg_1_0.viewGO, "#go_critter/#image_quality")
	arg_1_0._imagequalitylight = gohelper.findChildImage(arg_1_0.viewGO, "#go_critter/#image_qualitylight")
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_critter/#simage_icon")
	arg_1_0._simagecard = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_critter/#simage_card")
	arg_1_0._btnopenEgg = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_openEgg")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnopenEgg:AddClickListener(arg_2_0._btnopenEggOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnopenEgg:RemoveClickListener()
end

function var_0_0._btnopenEggOnClick(arg_4_0)
	if not arg_4_0.critterMO or arg_4_0:_isLockOp() then
		return
	end

	arg_4_0:_setLockTime(0.5)

	if arg_4_0._isOpenEgg then
		local var_4_0 = arg_4_0.critterMO:isMaturity()

		CritterController.instance:openRoomCritterDetailView(not var_4_0, arg_4_0.critterMO)

		return
	end

	local var_4_1 = {
		mode = RoomSummonEnum.SummonType.Summon,
		critterMo = arg_4_0.critterMO
	}

	CritterSummonController.instance:openSummonGetCritterView(var_4_1, true)
	arg_4_0:setOpenEgg(true)
end

function var_0_0._isLockOp(arg_5_0)
	if arg_5_0._nextLockTime and arg_5_0._nextLockTime > Time.time then
		return true
	end

	return false
end

function var_0_0._setLockTime(arg_6_0, arg_6_1)
	arg_6_0._nextLockTime = Time.time + tonumber(arg_6_1)
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0._iconRareScaleMap = {
		1.3,
		1.3,
		1.3,
		1.8,
		1.8
	}
	arg_7_0._isOpenEgg = false
	arg_7_0._eggDict = {}
	arg_7_0._simageiconTrs = arg_7_0._simageicon.transform
	arg_7_0._animatorPlayer = SLFramework.AnimatorPlayer.Get(arg_7_0.viewGO)

	arg_7_0:setOpenEgg(arg_7_0._isOpenEgg)
end

function var_0_0._editableAddEvents(arg_8_0)
	return
end

function var_0_0._editableRemoveEvents(arg_9_0)
	return
end

function var_0_0.onUpdateMO(arg_10_0, arg_10_1)
	arg_10_0.critterMO = arg_10_1

	gohelper.setActive(arg_10_0.viewGO, arg_10_1)
	arg_10_0:_refreshUI()
end

function var_0_0.setOpenEgg(arg_11_0, arg_11_1)
	local var_11_0 = false

	if arg_11_1 == true then
		var_11_0 = true
	end

	arg_11_0._isOpenEgg = var_11_0

	gohelper.setActive(arg_11_0._gocritter, arg_11_0._isOpenEgg and arg_11_0._isLaseOpenEgg)
end

function var_0_0.playAnim(arg_12_0, arg_12_1)
	local var_12_0 = false

	if arg_12_1 == true then
		var_12_0 = true
	end

	if arg_12_0._isLaseOpenEgg == var_12_0 then
		return false
	end

	arg_12_0._isLaseOpenEgg = var_12_0

	local var_12_1 = arg_12_0._eggDict[arg_12_0._lastRate]

	if var_12_1 then
		if arg_12_0._isLaseOpenEgg then
			var_12_1:playOpenAnim()
		else
			var_12_1:playIdleAnim()
		end
	end

	gohelper.setActive(arg_12_0._gocritter, arg_12_0._isLaseOpenEgg)
	arg_12_0._animatorPlayer:Play(arg_12_0._isLaseOpenEgg and "open" or "close", nil, nil)
	arg_12_0:_setLockTime(0.5)

	return true
end

function var_0_0.isOpenEgg(arg_13_0)
	return arg_13_0._isOpenEgg
end

function var_0_0.onSelect(arg_14_0, arg_14_1)
	return
end

var_0_0._EGG_NAME_DICT = {
	"roomcrittersummonresult_egg1.prefab",
	"roomcrittersummonresult_egg1.prefab",
	"roomcrittersummonresult_egg1.prefab",
	"roomcrittersummonresult_egg2.prefab",
	"roomcrittersummonresult_egg3.prefab"
}

function var_0_0._setShowCompByRare(arg_15_0, arg_15_1)
	if arg_15_0._lastRate == arg_15_1 then
		return
	end

	arg_15_0._lastRate = arg_15_1

	if not arg_15_0._eggDict[arg_15_1] then
		local var_15_0 = CritterEnum.QualityEggSummomResNameMap[arg_15_1]

		if var_15_0 then
			local var_15_1 = ResUrl.getRoomCritterEggPrefab(var_15_0)
			local var_15_2 = arg_15_0._view:getResInst(var_15_1, arg_15_0._goegg)

			transformhelper.setLocalScale(var_15_2.transform, 0.55, 0.55, 0.55)

			local var_15_3 = MonoHelper.addNoUpdateLuaComOnceToGo(var_15_2, RoomGetCritterEgg)

			var_15_3.eggRare = arg_15_1
			arg_15_0._eggDict[arg_15_1] = var_15_3

			if arg_15_0._isLaseOpenEgg then
				var_15_3:playOpenAnim()
			else
				var_15_3:playIdleAnim()
			end
		end
	end

	for iter_15_0, iter_15_1 in pairs(arg_15_0._eggDict) do
		gohelper.setActive(iter_15_1.go, iter_15_0 == arg_15_1)
	end
end

function var_0_0.openEggAnim(arg_16_0)
	return
end

function var_0_0._refreshUI(arg_17_0)
	if not arg_17_0.critterMO then
		return
	end

	local var_17_0 = CritterConfig.instance:getCritterRare(arg_17_0.critterMO.defineId)

	if var_17_0 then
		UISpriteSetMgr.instance:setCritterSprite(arg_17_0._imagequality, CritterEnum.QualityEggImageNameMap[var_17_0])
		UISpriteSetMgr.instance:setCritterSprite(arg_17_0._imagequalitylight, CritterEnum.QualityEggLightImageNameMap[var_17_0])

		local var_17_1 = arg_17_0._iconRareScaleMap[var_17_0] or 1

		transformhelper.setLocalScale(arg_17_0._simageiconTrs, var_17_1, var_17_1, var_17_1)
		arg_17_0:_setShowCompByRare(var_17_0)
	end

	local var_17_2 = CritterConfig.instance:getCritterHeadIcon(arg_17_0.critterMO:getSkinId())

	if not string.nilorempty(var_17_2) then
		arg_17_0._simageicon:LoadImage(ResUrl.getCritterLargeIcon(var_17_2))
	end

	local var_17_3 = CritterConfig.instance:getCritterRareCfg(var_17_0)

	if var_17_3 then
		arg_17_0._simagecard:LoadImage(ResUrl.getRoomCritterIcon(var_17_3.cardRes))
	end
end

function var_0_0.onDestroyView(arg_18_0)
	arg_18_0._simageicon:UnLoadImage()
	arg_18_0._simagecard:UnLoadImage()

	for iter_18_0, iter_18_1 in pairs(arg_18_0._eggDict) do
		iter_18_1:onDestroy()
	end
end

return var_0_0

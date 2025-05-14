module("modules.logic.versionactivity2_2.eliminate.view.eliminateChess.EliminateTeamChessDetailItem", package.seeall)

local var_0_0 = class("EliminateTeamChessDetailItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._imageQuality = gohelper.findChildImage(arg_1_0.viewGO, "#image_Quality")
	arg_1_0._goLocked = gohelper.findChild(arg_1_0.viewGO, "#go_Locked")
	arg_1_0._goSelected = gohelper.findChild(arg_1_0.viewGO, "#go_Selected")
	arg_1_0._imageChess = gohelper.findChildImage(arg_1_0.viewGO, "ChessMask/#image_Chess")
	arg_1_0._txtFireNum = gohelper.findChildText(arg_1_0.viewGO, "image_Fire/#txt_FireNum")
	arg_1_0._goResources = gohelper.findChild(arg_1_0.viewGO, "#go_Resources")
	arg_1_0._goResource = gohelper.findChild(arg_1_0.viewGO, "#go_Resources/#go_Resource")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

local var_0_1 = ZProj.UIEffectsCollection

function var_0_0._editableAddEvents(arg_4_0)
	arg_4_0._goClick = gohelper.getClick(arg_4_0.viewGO)

	arg_4_0._goClick:AddClickListener(arg_4_0.onClick, arg_4_0)
end

function var_0_0._editableRemoveEvents(arg_5_0)
	if arg_5_0._goClick then
		arg_5_0._goClick:RemoveClickListener()
	end
end

function var_0_0.onClick(arg_6_0)
	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_activity_open)
	EliminateChessController.instance:dispatchEvent(EliminateChessEvent.ShowChessInfo, arg_6_0._soliderId)
end

function var_0_0.setSoliderId(arg_7_0, arg_7_1)
	arg_7_0._soliderId = arg_7_1

	arg_7_0:initInfo()
	arg_7_0:initResource()
	arg_7_0:refreshView()
end

function var_0_0.refreshView(arg_8_0)
	if arg_8_0._soliderId == nil then
		return
	end

	arg_8_0:canUse()
	arg_8_0:setGrayState()
end

function var_0_0.setGrayState(arg_9_0)
	if arg_9_0._effectCollection == nil then
		arg_9_0._effectCollection = var_0_1.Get(arg_9_0.viewGO)
	end

	if arg_9_0._effectCollection then
		arg_9_0._effectCollection:SetGray(not arg_9_0._canUse)
	end

	if arg_9_0.cacheColor == nil then
		arg_9_0.cacheColor = arg_9_0._imageChess.color
	end

	arg_9_0.cacheColor.a = arg_9_0._canUse and 1 or 0.5
	arg_9_0._imageChess.color = arg_9_0.cacheColor
end

function var_0_0.canUse(arg_10_0)
	arg_10_0._canUse = EliminateTeamChessModel.instance:canUseChess(arg_10_0._soliderId)

	return arg_10_0._canUse
end

function var_0_0.initInfo(arg_11_0)
	local var_11_0 = EliminateConfig.instance:getSoldierChessConfig(arg_11_0._soliderId)

	arg_11_0._txtFireNum.text = var_11_0.defaultPower

	if var_11_0 and not string.nilorempty(var_11_0.resPic) then
		UISpriteSetMgr.instance:setV2a2ChessSprite(arg_11_0._imageChess, var_11_0.resPic, false)
	end

	UISpriteSetMgr.instance:setV2a2EliminateSprite(arg_11_0._imageQuality, EliminateConfig.instance:getSoldierChessQualityImageName(var_11_0.level), false)
end

function var_0_0.initResource(arg_12_0)
	arg_12_0._cost = EliminateConfig.instance:getSoldierChessConfigConst(arg_12_0._soliderId)

	if not arg_12_0._cost then
		return
	end

	arg_12_0._resourceItem = arg_12_0:getUserDataTb_()

	for iter_12_0, iter_12_1 in ipairs(arg_12_0._cost) do
		local var_12_0 = iter_12_1[1]
		local var_12_1 = iter_12_1[2]
		local var_12_2 = gohelper.clone(arg_12_0._goResource, arg_12_0._goResources, var_12_0)
		local var_12_3 = gohelper.findChildImage(var_12_2, "#image_Quality")
		local var_12_4 = gohelper.findChildText(var_12_2, "#image_Quality/#txt_ResourceNum")

		UISpriteSetMgr.instance:setV2a2EliminateSprite(var_12_3, EliminateTeamChessEnum.ResourceTypeToImagePath[var_12_0], false)

		var_12_4.text = var_12_1

		gohelper.setActive(var_12_2, true)

		arg_12_0._resourceItem[var_12_0] = {
			item = var_12_2,
			resourceImage = var_12_3,
			resourceNumberText = var_12_4
		}
	end
end

function var_0_0.updateInfo(arg_13_0)
	return
end

function var_0_0.onDestroyView(arg_14_0)
	return
end

return var_0_0

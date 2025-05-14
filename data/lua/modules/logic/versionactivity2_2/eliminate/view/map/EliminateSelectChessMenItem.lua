module("modules.logic.versionactivity2_2.eliminate.view.map.EliminateSelectChessMenItem", package.seeall)

local var_0_0 = class("EliminateSelectChessMenItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goChessSelected = gohelper.findChild(arg_1_0.viewGO, "#go_ChessSelected")
	arg_1_0._goLocked = gohelper.findChild(arg_1_0.viewGO, "#go_Locked")
	arg_1_0._goUnLocked = gohelper.findChild(arg_1_0.viewGO, "#go_UnLocked")
	arg_1_0._imageChessQuality = gohelper.findChildImage(arg_1_0.viewGO, "#go_UnLocked/#image_ChessQuality")
	arg_1_0._imageChess = gohelper.findChildImage(arg_1_0.viewGO, "#go_UnLocked/#image_Chess")
	arg_1_0._goResource = gohelper.findChild(arg_1_0.viewGO, "#go_UnLocked/#go_Resource")
	arg_1_0._goResourceItem = gohelper.findChild(arg_1_0.viewGO, "#go_UnLocked/#go_Resource/#go_ResourceItem")
	arg_1_0._imageResourceQuality = gohelper.findChildImage(arg_1_0.viewGO, "#go_UnLocked/#go_Resource/#go_ResourceItem/#image_ResourceQuality")
	arg_1_0._txtResourceNum = gohelper.findChildText(arg_1_0.viewGO, "#go_UnLocked/#go_Resource/#go_ResourceItem/#image_ResourceQuality/#txt_ResourceNum")
	arg_1_0._txtFireNum = gohelper.findChildText(arg_1_0.viewGO, "#go_UnLocked/image_Fire/#txt_FireNum")

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

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._click = SLFramework.UGUI.UIClickListener.Get(arg_4_0.viewGO)
	arg_4_0._animator = SLFramework.AnimatorPlayer.Get(arg_4_0.viewGO)

	arg_4_0:addEventCb(EliminateMapController.instance, EliminateMapEvent.SelectChessMen, arg_4_0._onSelectChessMen, arg_4_0)
end

function var_0_0._editableAddEvents(arg_5_0)
	arg_5_0._click:AddClickListener(arg_5_0._onItemClick, arg_5_0)
end

function var_0_0._editableRemoveEvents(arg_6_0)
	arg_6_0._click:RemoveClickListener()
end

function var_0_0._onItemClick(arg_7_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

	if not arg_7_0._isUnlocked then
		GameFacade.showToast(ToastEnum.EliminateChessMenLocked)

		return
	end

	if not arg_7_0._isSelected then
		EliminateSelectChessMenListModel.instance:setSelectedChessMen(arg_7_0._mo)
	end

	if EliminateSelectChessMenListModel.instance:getQuickEdit() then
		EliminateMapController.instance:dispatchEvent(EliminateMapEvent.QuickSelectChessMen)
	end
end

function var_0_0._onSelectChessMen(arg_8_0)
	arg_8_0._isSelected = arg_8_0._mo == EliminateSelectChessMenListModel.instance:getSelectedChessMen()

	gohelper.setActive(arg_8_0._goChessSelected, arg_8_0._isSelected)
end

function var_0_0.onUpdateMO(arg_9_0, arg_9_1)
	arg_9_0._mo = arg_9_1
	arg_9_0._config = arg_9_1.config
	arg_9_0._isUnlocked = EliminateTeamSelectionModel.instance:hasChessPieceOrPreset(arg_9_0._config.id)

	gohelper.setActive(arg_9_0._goLocked, not arg_9_0._isUnlocked)
	gohelper.setActive(arg_9_0._goUnLocked, arg_9_0._isUnlocked)
	arg_9_0:_onSelectChessMen()

	if not arg_9_0._isUnlocked then
		arg_9_0._animator:Play("idle", arg_9_0._idleDone, arg_9_0)

		return
	end

	arg_9_0._txtFireNum.text = tostring(arg_9_0._config.defaultPower)

	local var_9_0 = arg_9_0._mo.costList

	gohelper.CreateObjList(arg_9_0, arg_9_0._onItemShow, var_9_0, arg_9_0._goResource, arg_9_0._goResourceItem)
	UISpriteSetMgr.instance:setV2a2ChessSprite(arg_9_0._imageChess, arg_9_0._config.resPic, false)
	UISpriteSetMgr.instance:setV2a2EliminateSprite(arg_9_0._imageChessQuality, "v2a2_eliminate_chessqualitybg_0" .. arg_9_0._config.level, false)

	if not EliminateMapController.hasOnceActionKey(EliminateMapEnum.PrefsKey.ChessUnlock, arg_9_0._config.id) then
		EliminateMapController.setOnceActionKey(EliminateMapEnum.PrefsKey.ChessUnlock, arg_9_0._config.id)
		gohelper.setActive(arg_9_0._goLocked, true)
		arg_9_0._animator:Play("unlock", arg_9_0._unlockDone, arg_9_0)
	end
end

function var_0_0._unlockDone(arg_10_0)
	arg_10_0._animator:Play("idle", arg_10_0._idleDone, arg_10_0)
	gohelper.setActive(arg_10_0._goLocked, false)
end

function var_0_0._idleDone(arg_11_0)
	return
end

function var_0_0._onItemShow(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = gohelper.findChildImage(arg_12_1, "#image_ResourceQuality")
	local var_12_1 = gohelper.findChildText(arg_12_1, "#image_ResourceQuality/#txt_ResourceNum")
	local var_12_2 = arg_12_2[1]

	UISpriteSetMgr.instance:setV2a2EliminateSprite(var_12_0, EliminateTeamChessEnum.ResourceTypeToImagePath[var_12_2], false)

	var_12_1.text = arg_12_2[2]
end

function var_0_0.onSelect(arg_13_0, arg_13_1)
	return
end

function var_0_0.onDestroyView(arg_14_0)
	return
end

return var_0_0

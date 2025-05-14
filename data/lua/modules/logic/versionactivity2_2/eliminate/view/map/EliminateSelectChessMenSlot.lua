module("modules.logic.versionactivity2_2.eliminate.view.map.EliminateSelectChessMenSlot", package.seeall)

local var_0_0 = class("EliminateSelectChessMenSlot", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goadd = gohelper.findChild(arg_1_0.viewGO, "#go_add")
	arg_1_0._goLocked = gohelper.findChild(arg_1_0.viewGO, "#go_Locked")
	arg_1_0._godetail = gohelper.findChild(arg_1_0.viewGO, "#go_detail")
	arg_1_0._imageQuality = gohelper.findChildImage(arg_1_0.viewGO, "#go_detail/#image_Quality")
	arg_1_0._imageChess = gohelper.findChildImage(arg_1_0.viewGO, "#go_detail/ChessMask/#image_Chess")
	arg_1_0._txtFireNum = gohelper.findChildText(arg_1_0.viewGO, "#go_detail/image_Fire/#txt_FireNum")
	arg_1_0._goResources = gohelper.findChild(arg_1_0.viewGO, "#go_detail/#go_Resources")
	arg_1_0._goResourceItem = gohelper.findChild(arg_1_0.viewGO, "#go_detail/#go_Resources/#go_ResourceItem")
	arg_1_0._imageResourceQuality = gohelper.findChildImage(arg_1_0.viewGO, "#go_detail/#go_Resources/#go_ResourceItem/#image_ResourceQuality")
	arg_1_0._txtResourceNum = gohelper.findChildText(arg_1_0.viewGO, "#go_detail/#go_Resources/#go_ResourceItem/#image_ResourceQuality/#txt_ResourceNum")
	arg_1_0._goAssist = gohelper.findChild(arg_1_0.viewGO, "#go_Assist")

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

	arg_4_0:addEventCb(EliminateMapController.instance, EliminateMapEvent.SelectChessMen, arg_4_0._onSelectChessMen, arg_4_0)

	arg_4_0._isPreset = EliminateTeamSelectionModel.instance:isPreset()

	gohelper.setActive(arg_4_0._goAssist, false)
end

function var_0_0._editableAddEvents(arg_5_0)
	arg_5_0._click:AddClickListener(arg_5_0._onItemClick, arg_5_0)
end

function var_0_0._editableRemoveEvents(arg_6_0)
	arg_6_0._click:RemoveClickListener()
end

function var_0_0._onItemClick(arg_7_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

	if arg_7_0._isUnlocked and arg_7_0._mo then
		EliminateSelectChessMenListModel.instance:setSelectedChessMen(arg_7_0._mo)

		if EliminateSelectChessMenListModel.instance:getQuickEdit() then
			EliminateMapController.instance:dispatchEvent(EliminateMapEvent.QuickSelectChessMen)
		end
	end
end

function var_0_0.setIndex(arg_8_0, arg_8_1)
	arg_8_0._index = arg_8_1
	arg_8_0._isUnlocked = arg_8_1 <= EliminateSelectChessMenListModel.instance:getAddMaxCount()
end

function var_0_0._onSelectChessMen(arg_9_0)
	arg_9_0._isSelected = arg_9_0._mo == EliminateSelectChessMenListModel.instance:getSelectedChessMen()

	gohelper.setActive(arg_9_0._goSelected, arg_9_0._isSelected)
end

function var_0_0.onUpdateMO(arg_10_0, arg_10_1)
	arg_10_0._mo = arg_10_1

	gohelper.setActive(arg_10_0._goLocked, not arg_10_0._isUnlocked)
	gohelper.setActive(arg_10_0._goadd, arg_10_0._isUnlocked and not arg_10_0._mo)
	gohelper.setActive(arg_10_0._godetail, arg_10_0._isUnlocked and arg_10_0._mo)
	gohelper.setActive(arg_10_0._goAssist, false)

	if not arg_10_0._mo then
		return
	end

	arg_10_0._config = arg_10_1.config
	arg_10_0._txtFireNum.text = tostring(arg_10_0._config.defaultPower)

	arg_10_0:_onSelectChessMen()
	UISpriteSetMgr.instance:setV2a2ChessSprite(arg_10_0._imageChess, arg_10_0._config.resPic, false)
	UISpriteSetMgr.instance:setV2a2EliminateSprite(arg_10_0._imageQuality, "v2a2_eliminate_builditem_quality_0" .. arg_10_0._config.level, false)
	gohelper.setActive(arg_10_0._goAssist, arg_10_0._isPreset)

	local var_10_0 = arg_10_0._mo.costList

	gohelper.CreateObjList(arg_10_0, arg_10_0._onItemShow, var_10_0, arg_10_0._goResources, arg_10_0._goResourceItem)
end

function var_0_0._onItemShow(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = gohelper.findChildImage(arg_11_1, "#image_ResourceQuality")
	local var_11_1 = gohelper.findChildText(arg_11_1, "#image_ResourceQuality/#txt_ResourceNum")
	local var_11_2 = arg_11_2[1]

	UISpriteSetMgr.instance:setV2a2EliminateSprite(var_11_0, EliminateTeamChessEnum.ResourceTypeToImagePath[var_11_2], false)

	var_11_1.text = arg_11_2[2]
end

function var_0_0.onSelect(arg_12_0, arg_12_1)
	return
end

function var_0_0.onDestroyView(arg_13_0)
	return
end

return var_0_0

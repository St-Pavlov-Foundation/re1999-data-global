module("modules.logic.versionactivity1_8.dungeon.view.factory.repairgame.VersionActivity1_8FactoryRepairGameMap", package.seeall)

slot0 = class("VersionActivity1_8FactoryRepairGameMap", BaseView)
slot1 = 123
slot2 = 123

function slot0.onInitView(slot0)
	slot0._gomap = gohelper.findChild(slot0.viewGO, "#go_map")
	slot0._gomapTrs = slot0._gomap.transform
	slot0._btnMapClick = SLFramework.UGUI.UIClickListener.Get(slot0._gomap)
	slot0._btnreset = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_reset")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(Activity157Controller.instance, ArmPuzzlePipeEvent.GuideClickGrid, slot0._onGuideClickGrid, slot0)
	slot0:addEventCb(Activity157Controller.instance, ArmPuzzlePipeEvent.PlaceRefreshPipesGrid, slot0._onPlaceRefreshPipesGrid, slot0)
	slot0:addEventCb(Activity157Controller.instance, ArmPuzzlePipeEvent.PipeGameClear, slot0._onGameClear, slot0)
	slot0._btnMapClick:AddClickListener(slot0._btnMapOnClick, slot0)
	slot0._btnreset:AddClickListener(slot0._btnresetOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(Activity157Controller.instance, ArmPuzzlePipeEvent.GuideClickGrid, slot0._onGuideClickGrid, slot0)
	slot0:removeEventCb(Activity157Controller.instance, ArmPuzzlePipeEvent.PlaceRefreshPipesGrid, slot0._onPlaceRefreshPipesGrid, slot0)
	slot0:removeEventCb(Activity157Controller.instance, ArmPuzzlePipeEvent.PipeGameClear, slot0._onGameClear, slot0)
	slot0._btnMapClick:RemoveClickListener()
	slot0._btnreset:RemoveClickListener()
end

function slot0._onGuideClickGrid(slot0, slot1)
	slot2 = string.splitToNumber(slot1, "_")

	slot0:_onClickGridItem(slot2[1], slot2[2])
end

function slot0._onPlaceRefreshPipesGrid(slot0, slot1, slot2)
	if not Activity157RepairGameModel.instance:getData(slot1, slot2) then
		return
	end

	Activity157Controller.instance:refreshConnection(slot3)
	Activity157Controller.instance:updateConnection()
	slot0:initItem(slot1, slot2)
	slot0:_refreshConnection()
	slot0:_refreshEntryItem()

	slot0._canTouch = not Activity157RepairGameModel.instance:getGameClear()

	Activity157Controller.instance:checkDispatchClear()
end

function slot0._onGameClear(slot0)
	VersionActivity1_8StatController.instance:statSuccess()
end

function slot0._btnMapOnClick(slot0)
	slot0:_onClickContainer(GamepadController.instance:getMousePosition())
end

function slot0._onClickContainer(slot0, slot1)
	slot2 = recthelper.screenPosToAnchorPos(slot1, slot0._gomapTrs)
	slot3, slot4 = Activity157RepairGameModel.instance:getIndexByTouchPos(slot2.x, slot2.y, uv0, uv1)

	if slot3 ~= -1 then
		slot0:_onClickGridItem(slot3, slot4)
	end
end

function slot0._onClickGridItem(slot0, slot1, slot2)
	if not slot0._canTouch then
		GameFacade.showToast(ToastEnum.V1a8Activity157RepairComplete)

		return
	end

	if Activity157RepairGameModel.instance:getData(slot1, slot2):isEntry() then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	Activity157Controller.instance:changeDirection(slot1, slot2, true)
	Activity157Controller.instance:updateConnection()
	slot0:_syncRotation(slot1, slot2, slot3)
	slot0:_refreshConnection()
	slot0:_refreshEntryItem()

	slot0._canTouch = not Activity157RepairGameModel.instance:getGameClear()

	Activity157Controller.instance:checkDispatchClear()
end

function slot0._syncRotation(slot0, slot1, slot2, slot3)
	if slot3:isEntry() then
		return
	end

	slot0._gridItemDict[slot1][slot2]:syncRotation(slot3)
end

function slot0._btnresetOnClick(slot0)
	if not slot0._canTouch then
		GameFacade.showToast(ToastEnum.V1a8Activity157RepairComplete)

		return
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.v1a8Activity157RestTip, MsgBoxEnum.BoxType.Yes_No, function ()
		uv0:_resetGame()
	end)
end

function slot0._resetGame(slot0)
	VersionActivity1_8StatController.instance:statReset()
	Activity157Controller.instance:resetGame()

	for slot4 = 1, slot0._gameWidth do
		for slot8 = 1, slot0._gameHeight do
			slot0:initItem(slot4, slot8)
			slot0:_refreshConnectItem(slot4, slot8)
		end
	end

	slot0:_refreshEntryItem()

	slot0._canTouch = not Activity157RepairGameModel.instance:getGameClear()
end

function slot0._editableInitView(slot0)
	slot0._canTouch = true
	slot0._gameWidth, slot0._gameHeight = Activity157RepairGameModel.instance:getGameSize()
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_unlock)

	slot0._gridItemDict = {}
	slot0._gridItemList = {}

	for slot4 = 1, slot0._gameWidth do
		slot0._gridItemDict[slot4] = slot0._gridItemDict[slot4] or {}

		for slot8 = 1, slot0._gameHeight do
			slot0:addNewItem(slot4, slot8)
		end
	end

	slot0:_refreshEntryItem()
end

function slot0.addNewItem(slot0, slot1, slot2)
	slot0:_newPipeItem(slot1, slot2)
	slot0:initItem(slot1, slot2)
	slot0:_refreshConnectItem(slot1, slot2)
end

function slot0._newPipeItem(slot0, slot1, slot2)
	slot4 = slot0:getResInst(slot0.viewContainer._viewSetting.otherRes[1], slot0._gomap, slot1 .. "_" .. slot2)
	slot6, slot7 = Activity157RepairGameModel.instance:getRelativePosition(slot1, slot2, uv0, uv1)

	recthelper.setAnchor(slot4.transform, slot6, slot7)

	slot8 = MonoHelper.addNoUpdateLuaComOnceToGo(slot4, VersionActivity1_8FactoryRepairGameMapItem)

	table.insert(slot0._gridItemList, slot8)

	slot0._gridItemDict[slot1][slot2] = slot8
end

function slot0.initItem(slot0, slot1, slot2)
	slot0._gridItemDict[slot1][slot2]:initItem(Activity157RepairGameModel.instance:getData(slot1, slot2))
end

function slot0._refreshConnection(slot0)
	for slot4 = 1, slot0._gameWidth do
		for slot8 = 1, slot0._gameHeight do
			slot0:_refreshConnectItem(slot4, slot8)
		end
	end
end

function slot0._refreshConnectItem(slot0, slot1, slot2)
	if slot1 > 0 and slot1 <= slot0._gameWidth and slot2 > 0 and slot2 <= slot0._gameHeight then
		slot0._gridItemDict[slot1][slot2]:initConnectObj(Activity157RepairGameModel.instance:getData(slot1, slot2))
	end
end

function slot0._refreshEntryItem(slot0)
	for slot5, slot6 in pairs(Activity157RepairGameModel.instance:getEntryList()) do
		slot9 = slot0._gridItemDict[slot6.x][slot6.y]

		slot9:initItem(slot6)
		slot9:initConnectObj(slot6)
	end
end

function slot0.getXYByPosition(slot0, slot1)
	slot2 = recthelper.screenPosToAnchorPos(slot1, slot0._gomapTrs)
	slot3, slot4 = Activity157RepairGameModel.instance:getIndexByTouchPos(slot2.x, slot2.y, uv0, uv1)

	if slot3 ~= -1 then
		return slot3, slot4
	end
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0

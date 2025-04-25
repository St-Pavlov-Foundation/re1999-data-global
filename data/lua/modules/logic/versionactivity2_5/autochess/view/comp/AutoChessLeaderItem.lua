module("modules.logic.versionactivity2_5.autochess.view.comp.AutoChessLeaderItem", package.seeall)

slot0 = class("AutoChessLeaderItem", LuaCompBase)

function slot0.ctor(slot0, slot1)
	slot0.handleView = slot1
end

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._btnClick = gohelper.findChildButtonWithAudio(slot1, "#btn_Click")
	slot0._goSelectFrame = gohelper.findChild(slot1, "#go_SelectFrame")
	slot0._goUnLock = gohelper.findChild(slot1, "#go_UnLock")
	slot0._uiMesh = gohelper.findChildUIMesh(slot1, "#go_UnLock/Mesh")
	slot0._simageRole = gohelper.findChildSingleImage(slot1, "#go_UnLock/Mesh/role")
	slot0._imageRole = gohelper.findChildImage(slot1, "#go_UnLock/Mesh/role")
	slot0._txtHp = gohelper.findChildText(slot1, "#go_UnLock/hp/#txt_Hp")
	slot0._btnCheck = gohelper.findChildButtonWithAudio(slot1, "#go_UnLock/#btn_Check")
	slot0._goSelect = gohelper.findChild(slot1, "#go_Select")
	slot0._goLock = gohelper.findChild(slot1, "#go_Lock")
	slot0._txtLock = gohelper.findChildText(slot1, "#go_Lock/#txt_Lock")

	gohelper.setActive(slot0._btnClick, slot0.handleView)
	gohelper.setActive(slot0._btnCheck, slot0.handleView)
end

function slot0.addEventListeners(slot0)
	slot0:addClickCb(slot0._btnClick, slot0.onClick, slot0)
	slot0:addClickCb(slot0._btnCheck, slot0.onCheck, slot0)
end

function slot0.onDestroy(slot0)
	if slot0.loader then
		slot0.loader:dispose()

		slot0.loader = nil
	end
end

function slot0.setData(slot0, slot1)
	if slot1 then
		slot0.id = slot1
		slot0.config = lua_auto_chess_master.configDict[slot1]

		slot0._simageRole:LoadImage(ResUrl.getAutoChessIcon(slot0.config.image), slot0.loadCallback, slot0)
		slot0:loadMesh()

		slot0._txtHp.text = slot0.config.hp
	else
		slot0._txtLock.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("autochess_leaderitem_unlock"), lua_auto_chess_episode.configDict[tonumber(lua_auto_chess_const.configDict[AutoChessEnum.ConstKey.UnlockLeaderSlot].value)].name)
	end

	gohelper.setActive(slot0._goUnLock, slot1)
	gohelper.setActive(slot0._goLock, not slot1)
end

function slot0.refreshSelect(slot0, slot1)
	gohelper.setActive(slot0._goSelect, slot1)
	gohelper.setActive(slot0._goSelectFrame, slot1)
end

function slot0.onClick(slot0)
	if not slot0.id then
		return
	end

	slot0.handleView:onClickLeader(slot0)
end

function slot0.onCheck(slot0)
	ViewMgr.instance:openView(ViewName.AutoChessLeaderShowView, {
		leaderId = slot0.id
	})
end

function slot0.loadMesh(slot0)
	slot0.meshUrl = AutoChessHelper.getMeshUrl(slot0.config.image)
	slot0.loader = MultiAbLoader.New()

	slot0.loader:addPath(slot0.meshUrl)
	slot0.loader:startLoad(slot0.loadResFinish, slot0)
end

function slot0.loadResFinish(slot0)
	slot0._uiMesh.mesh = slot0.loader:getAssetItem(slot0.meshUrl):GetResource(slot0.meshUrl)

	slot0._uiMesh:SetVerticesDirty()
end

function slot0.loadCallback(slot0)
	slot0._imageRole:SetNativeSize()
end

return slot0

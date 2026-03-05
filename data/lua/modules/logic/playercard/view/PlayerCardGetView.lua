-- chunkname: @modules/logic/playercard/view/PlayerCardGetView.lua

module("modules.logic.playercard.view.PlayerCardGetView", package.seeall)

local PlayerCardGetView = class("PlayerCardGetView", BaseView)

function PlayerCardGetView:onInitView()
	self._gomainUI = gohelper.findChild(self.viewGO, "middle/#go_mainUI")
	self._btnequip = gohelper.findChildButtonWithAudio(self.viewGO, "right/start/#btn_equip")
	self._goshowing = gohelper.findChild(self.viewGO, "right/start/#go_showing")
	self._goLocked = gohelper.findChild(self.viewGO, "right/start/#go_Locked")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "right/start/#btn_close")
	self._scrollcard = gohelper.findChildScrollRect(self.viewGO, "right/mask/#scroll_card")
	self._goSceneName = gohelper.findChild(self.viewGO, "left/LayoutGroup/#go_SceneName")
	self._txtBgName = gohelper.findChildText(self.viewGO, "left/LayoutGroup/#go_SceneName/#txt_SceneName")
	self._txtTime = gohelper.findChildText(self.viewGO, "left/LayoutGroup/#go_SceneName/#txt_SceneName/#txt_Time")
	self._txtBgDescr = gohelper.findChildText(self.viewGO, "left/#txt_SceneDescr")
	self._btnshow = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_show")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function PlayerCardGetView:addEvents()
	self._btnequip:AddClickListener(self._btnequipOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnshow:AddClickListener(self._btnshowOnClick, self)
	self:addEventCb(PlayerCardController.instance, PlayerCardEvent.ChangeSkin, self._onChangeSkin, self)
end

function PlayerCardGetView:removeEvents()
	self._btnequip:RemoveClickListener()
	self._btnclose:RemoveClickListener()
	self._btnshow:RemoveClickListener()
end

function PlayerCardGetView:_btnequipOnClick()
	PlayerCardController.instance:setPlayerCardSkin(self._id)
end

function PlayerCardGetView:_btncloseOnClick()
	self:closeThis()
end

function PlayerCardGetView:_btnshowOnClick()
	return
end

function PlayerCardGetView:_editableInitView()
	return
end

function PlayerCardGetView:onUpdateParam()
	return
end

function PlayerCardGetView:onOpen()
	self._id = self.viewParam and self.viewParam.id
	self._config = ItemConfig.instance:getItemCo(self._id)

	local pathname = string.format("playercardview_%s", self._id)

	self._cardPath = string.format("ui/viewres/player/playercard/%s.prefab", pathname)
	self._cardLoader = MultiAbLoader.New()

	self._cardLoader:addPath(self._cardPath)
	self._cardLoader:startLoad(self._onCardLoadFinish, self)
	self:_initInfo()
end

function PlayerCardGetView:_onCardLoadFinish()
	local assetItem = self._cardLoader:getAssetItem(self._cardPath)
	local viewPrefab = assetItem:GetResource(self._cardPath)

	self._viewGo = self._viewGo or gohelper.clone(viewPrefab, self._gomainUI)
	self._viewCls = self._viewCls or MonoHelper.addNoUpdateLuaComOnceToGo(self._viewGo, PlayerCardGetMainView)
	self._viewCls.viewParam = {
		userId = PlayerModel.instance:getPlayinfo().userId
	}
	self._viewCls.viewContainer = self.viewContainer

	self._viewCls:onOpen(self._id)
end

function PlayerCardGetView:_initInfo()
	local dt = ServerTime.nowDateInLocal()
	local time = string.format("%04d/%02d/%02d", dt.year, dt.month, dt.day)

	self._txtTime.text = string.format(luaLang("receive_time"), time)
	self._txtBgName.text = self._config.name
	self._txtBgDescr.text = self._config.desc
end

function PlayerCardGetView:onClose()
	PlayerCardController.instance:openSimpleShowView()
end

function PlayerCardGetView:_onChangeSkin(skinId)
	local isSelect = self._id == skinId

	gohelper.setActive(self._btnequip.gameObject, not isSelect)
	gohelper.setActive(self._goshowing, isSelect)
	GameFacade.showToast(ToastEnum.PlayerCardChangeSkin)
end

function PlayerCardGetView:onDestroyView()
	return
end

return PlayerCardGetView

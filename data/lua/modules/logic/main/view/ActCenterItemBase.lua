-- chunkname: @modules/logic/main/view/ActCenterItemBase.lua

module("modules.logic.main.view.ActCenterItemBase", package.seeall)

local ActCenterItemBase = class("ActCenterItemBase", LuaCompBase)

function ActCenterItemBase:init(go)
	self:__onInit()

	self.go = go
	self._transform = go.transform
	self._imgGo = gohelper.findChild(go, "bg")
	self._imgitem = gohelper.findChildImage(go, "bg")
	self._btnitem = gohelper.findChildClick(go, "bg")
	self._goactivityreddot = gohelper.findChild(go, "go_activityreddot")
	self._txttheme = gohelper.findChildText(go, "txt_theme")
	self._godeadline = gohelper.findChild(go, "#go_deadline")
	self._txttime = gohelper.findChildText(go, "#go_deadline/#txt_time")
	self._act_iconbgGo = gohelper.findChild(go, "act_iconbg")
	self._act_iconbg_effGo = gohelper.findChild(go, "act_iconbg_eff")
	self._goexpup = gohelper.findChild(self.go, "#go_expup")

	self:_initActEff()

	self._goexpup = gohelper.findChild(self.go, "#go_expup")

	self:onInit(go)
	self:_addEvent()
	gohelper.setActive(go, true)
end

function ActCenterItemBase:onDestroyView()
	self:_removeEvent()
	self:onDestroy()
	gohelper.destroy(self.go)
	self:__onDispose()
end

function ActCenterItemBase:_addEvent()
	self._btnitem:AddClickListener(self.onClick, self)
	self:onAddEvent()
end

function ActCenterItemBase:_removeEvent()
	self._btnitem:RemoveClickListener()
	self:onRemoveEvent()
end

function ActCenterItemBase:_onOpen(...)
	self:onOpen(...)
end

function ActCenterItemBase:refresh(...)
	if not self.__isFirst then
		self:_onOpen(...)

		self.__isFirst = true
	end

	self:onRefresh(...)
end

function ActCenterItemBase:_addNotEventRedDot(cb, cbObj)
	self._redDot = RedDotController.instance:addNotEventRedDot(self._goactivityreddot, cb, cbObj)
end

function ActCenterItemBase:isShowRedDot()
	return self._redDot and self._redDot.isShowRedDot
end

function ActCenterItemBase:_setMainSprite(spriteName)
	UISpriteSetMgr.instance:setMainSprite(self._imgitem, spriteName)
end

function ActCenterItemBase:setSiblingIndex(index)
	self._transform:SetSiblingIndex(index)
end

function ActCenterItemBase:_refreshRedDot()
	if self._redDot then
		self._redDot:refreshRedDot()
	end
end

function ActCenterItemBase:setCustomData(data)
	self._data = data
end

function ActCenterItemBase:getCustomData()
	return self._data
end

function ActCenterItemBase:getMainActAtmosphereConfig()
	return ActivityConfig.instance:getMainActAtmosphereConfig()
end

function ActCenterItemBase:isShowActivityEffect(forceUpdate)
	if self._isShowActivityEffect == nil or forceUpdate then
		self._isShowActivityEffect = ActivityModel.showActivityEffect()
	end

	return self._isShowActivityEffect
end

function ActCenterItemBase:_initActEff()
	local mainActAtmosphereConfig = ActivityConfig.instance:getMainActAtmosphereConfig()

	self._mainViewActBtnGoList = self:getUserDataTb_()

	for i, path in ipairs(mainActAtmosphereConfig.mainViewActBtn or {}) do
		self._mainViewActBtnGoList[i] = gohelper.findChild(self.go, path)
	end

	local isShow = self:isShowActivityEffect()

	for _, go in pairs(self._mainViewActBtnGoList) do
		gohelper.setActive(go, isShow)
	end

	self:_setActive_act_iconbg(isShow and ActivityModel.checkIsShowFxVisible())
end

function ActCenterItemBase:onInit(go)
	return
end

function ActCenterItemBase:onDestroy()
	return
end

function ActCenterItemBase:onOpen()
	return
end

function ActCenterItemBase:onRefresh(...)
	self:refreshRedDot()
end

function ActCenterItemBase:onAddEvent()
	return
end

function ActCenterItemBase:onRemoveEvent()
	return
end

function ActCenterItemBase:onClick()
	assert(false, "please override 'onClick' function!!")
end

function ActCenterItemBase:_setActive_act_iconbg(isActive)
	gohelper.setActive(self._act_iconbgGo, isActive)
	gohelper.setActive(self._act_iconbg_effGo, isActive)
end

return ActCenterItemBase

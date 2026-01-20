-- chunkname: @modules/logic/battlepass/view/BpSPMainBtnItem.lua

module("modules.logic.battlepass.view.BpSPMainBtnItem", package.seeall)

local BpSPMainBtnItem = class("BpSPMainBtnItem", ActCenterItemBase)

function BpSPMainBtnItem:init(go)
	BpSPMainBtnItem.super.init(self, gohelper.cloneInPlace(go))
end

function BpSPMainBtnItem:onInit(go)
	self._btnitem = gohelper.getClickWithAudio(self._imgGo, AudioEnum.UI.play_ui_role_pieces_open)

	self:_refreshItem()
end

function BpSPMainBtnItem:onClick()
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.BP) then
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.BP))

		return
	end

	BpController.instance:openBattlePassView(true)
end

function BpSPMainBtnItem:_refreshItem()
	local isShow = ActivityModel.showActivityEffect()
	local atmoConfig = ActivityConfig.instance:getMainActAtmosphereConfig()
	local spriteName = isShow and atmoConfig.mainViewActBtnPrefix .. "icon_6" or "icon_6"

	UISpriteSetMgr.instance:setMainSprite(self._imgitem, spriteName, true)

	if not isShow then
		local config = ActivityConfig.instance:getMainActAtmosphereConfig()

		if config then
			for _, path in ipairs(config.mainViewActBtn) do
				local go = gohelper.findChild(self.go, path)

				if go then
					gohelper.setActive(go, isShow)
				end
			end
		end
	end

	self._redDot = RedDotController.instance:addRedDot(self._goactivityreddot, RedDotEnum.DotNode.BattlePassSPMain)
end

function BpSPMainBtnItem:isShowRedDot()
	return self._redDot and self._redDot.isShowRedDot
end

return BpSPMainBtnItem

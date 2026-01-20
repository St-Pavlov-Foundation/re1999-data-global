-- chunkname: @modules/logic/fight/view/FightViewDialogItem.lua

module("modules.logic.fight.view.FightViewDialogItem", package.seeall)

local FightViewDialogItem = class("FightViewDialogItem", LuaCompBase)

function FightViewDialogItem:ctor(fightViewDialog)
	FightViewDialogItem.super.ctor(self)

	self._fightViewDialog = fightViewDialog
end

function FightViewDialogItem:init(go)
	self.go = go
	self._gocontainer = gohelper.findChild(go, "container/simagebg")
	self._simageicon = gohelper.findChildSingleImage(go, "container/simagebg/headframe/headicon")
	self._goframe = gohelper.findChild(go, "container/simagebg/headframe")
	self._txtdialog = gohelper.findChildText(go, "container/simagebg/go_normalcontent/txt_contentcn")
	self._goNormalContent = gohelper.findChild(go, "container/simagebg/go_normalcontent")

	if self._simageicon == nil then
		self._simageicon = gohelper.findChildSingleImage(go, "container/headframe/headicon")
	end

	if self._goframe == nil then
		self._goframe = gohelper.findChild(go, "container/headframe")
	end

	if self._txtdialog == nil then
		self._txtdialog = gohelper.findChildText(go, "container/go_normalcontent/txt_contentcn")
	end

	if self._goNormalContent == nil then
		self._goNormalContent = gohelper.findChild(go, "container/go_normalcontent")
	end

	self._canvasGroup = self._gocontainer:GetComponent(typeof(UnityEngine.CanvasGroup))
end

function FightViewDialogItem:showDialogContent(icon, config)
	gohelper.setActive(self._goframe, icon ~= nil)
	gohelper.setActive(self._simageicon.gameObject, icon ~= nil)

	if icon then
		if self._simageicon.curImageUrl ~= icon then
			self._simageicon:UnLoadImage()
		end

		self._simageicon:LoadImage(icon)
	end

	self._txtdialog.text = config.text

	self._txtdialog:GetPreferredValues()

	if not self._tmpFadeIn then
		self._tmpFadeIn = MonoHelper.addLuaComOnceToGo(self._gocontainer, TMPFadeIn)

		self._tmpFadeIn:setTopOffset(0, -2.4)
		self._tmpFadeIn:setLineSpacing(26)
	end

	self._tmpFadeIn:playNormalText(config.text)
	recthelper.setAnchorX(self._goframe.transform, config.tipsDir == 2 and 920 or 0)
	recthelper.setAnchorX(self._goNormalContent.transform, config.tipsDir == 2 and 382 or 529.2)

	local anchor = config.tipsDir == 2 and Vector2(1, 1) or Vector2(0, 1)

	self.go.transform.anchorMin = anchor
	self.go.transform.anchorMax = anchor

	recthelper.setAnchorX(self.go.transform, config.tipsDir == 2 and -1100 or 208.6)

	if self._gocontainer then
		local layout = self._gocontainer:GetComponent(typeof(UnityEngine.UI.HorizontalLayoutGroup))

		if layout then
			local left = config.tipsDir == 2 and -120 or 150

			layout.padding.left = left
		end
	end
end

function FightViewDialogItem:onDestroy()
	GameUtil.onDestroyViewMember(self, "_tmpFadeIn")
	self._simageicon:UnLoadImage()
end

return FightViewDialogItem

-- chunkname: @modules/logic/character/view/CharacterVoiceItem.lua

module("modules.logic.character.view.CharacterVoiceItem", package.seeall)

local CharacterVoiceItem = class("CharacterVoiceItem", ListScrollCellExtend)
local itemShowAniName = "voiceview_item_in"

function CharacterVoiceItem:onInitView()
	self._itemclick = SLFramework.UGUI.UIClickListener.Get(self.viewGO)
	self._itemAnimator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._goplayicon = gohelper.findChild(self.viewGO, "#go_playicon")
	self._gostopicon = gohelper.findChild(self.viewGO, "#go_stopicon")
	self._golockicon = gohelper.findChild(self.viewGO, "#go_lockicon")
	self._govoice = gohelper.findChild(self.viewGO, "voice")
	self._govoicemask = gohelper.findChild(self.viewGO, "voice/mask")
	self._txtvoicename = gohelper.findChildText(self.viewGO, "voice/mask/#txt_voicename")
	self._golockvoice = gohelper.findChild(self.viewGO, "lockvoice")
	self._txtlockvoicename = gohelper.findChildText(self.viewGO, "lockvoice/#txt_lockvoicename")
	self._govoiceicon = gohelper.findChild(self.viewGO, "#go_voiceicon")
	self.moveduration = 1.5
	self.gapduration = 0.5
	self.backduration = 1.5

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterVoiceItem:addEvents()
	self._itemclick:AddClickListener(self._itemOnClick, self)
	self:addEventCb(CharacterController.instance, CharacterEvent.ChangeVoiceLang, self._onChangeCharVoiceLang, self)
end

function CharacterVoiceItem:removeEvents()
	self._itemclick:RemoveClickListener()
end

function CharacterVoiceItem:_itemOnClick()
	if CharacterDataModel.instance:isCurHeroAudioLocked(self._audioId) then
		return
	end

	if CharacterDataModel.instance:isCurHeroAudioPlaying(self._audioId) then
		CharacterController.instance:dispatchEvent(CharacterEvent.StopVoice, self._audioId)
		self:_checkplayingcallback()
	else
		self:_checkplayingcallback()
		self:_setRandomVoiceId()
		CharacterDataModel.instance:setPlayingInfo(self._audioId, self._defaultAudioId)
		CharacterController.instance:dispatchEvent(CharacterEvent.PlayVoice, self._audioId)
	end
end

function CharacterVoiceItem:_setRandomVoiceId()
	if not self._multiVoiceList then
		local heroinfo = HeroModel.instance:getByHeroId(self._mo.heroId)
		local skinCo = SkinConfig.instance:getSkinCo(heroinfo.skin)
		local list = CharacterDataConfig.instance:getCharacterTypeVoicesCO(self._mo.heroId, CharacterEnum.VoiceType.MultiVoice, skinCo.id)

		self._multiVoiceList = {}

		for i, v in ipairs(list) do
			if tonumber(v.param) == self._defaultAudioId then
				table.insert(self._multiVoiceList, v)
			end
		end
	end

	local targetAudioId

	if #self._multiVoiceList > 0 and math.random() > 0.5 then
		local config = self._multiVoiceList[math.random(#self._multiVoiceList)]

		targetAudioId = config and config.audio
	end

	self._audioId = targetAudioId or self._defaultAudioId
end

function CharacterVoiceItem:_checkplayingcallback()
	if self.playcallback then
		TaskDispatcher.cancelTask(self.playcallback, self)

		self.playcallback = nil
	end

	ZProj.TweenHelper.KillByObj(self._txtvoicename.transform)
	recthelper.setAnchorX(self._txtvoicename.transform, 0)
end

function CharacterVoiceItem:_editableInitView()
	return
end

function CharacterVoiceItem:onUpdateMO(mo)
	self._mo = mo
	self._multiVoiceList = nil
	self._defaultAudioId = self._mo.id
	self._audioId = CharacterDataModel.instance:getPlayingAudioId(self._defaultAudioId) or self._defaultAudioId

	transformhelper.setLocalScale(self._gostopicon.transform, 1, 1, 1)
	self:_refreshItem()
end

function CharacterVoiceItem:_refreshItem()
	self._itemAnimator.enabled = CharacterVoiceModel.instance:isNeedItemAni()

	if CharacterDataModel.instance:isCurHeroAudioLocked(self._audioId) then
		gohelper.setActive(self._golockicon, true)
		gohelper.setActive(self._goplayicon, false)
		gohelper.setActive(self._gostopicon, false)
		gohelper.setActive(self._govoiceicon, false)
		gohelper.setActive(self._golockvoice, true)
		gohelper.setActive(self._govoice, false)
		SLFramework.UGUI.GuiHelper.SetColor(self._txtvoicename, "#9D9D9D")

		local heroInfo = HeroModel.instance:getByHeroId(self._mo.heroId)

		self._txtlockvoicename.text = CharacterDataConfig.instance:getConditionStringName(self._mo)
	else
		local isplaying = CharacterDataModel.instance:isCurHeroAudioPlaying(self._audioId)

		gohelper.setActive(self._golockvoice, false)
		gohelper.setActive(self._govoice, true)
		gohelper.setActive(self._golockicon, false)
		gohelper.setActive(self._goplayicon, not isplaying)
		gohelper.setActive(self._gostopicon, isplaying)
		gohelper.setActive(self._govoiceicon, isplaying)

		self._txtvoicename.text = " " .. self._mo.name

		if isplaying then
			SLFramework.UGUI.GuiHelper.SetColor(self._txtvoicename, "#C66030")
			self:_checkloopVoiceName(isplaying)
		else
			self:_checkplayingcallback()
			SLFramework.UGUI.GuiHelper.SetColor(self._txtvoicename, "#E2E1DF")
		end
	end
end

function CharacterVoiceItem:_checkloopVoiceName(isplaying)
	if self.playcallback then
		return
	end

	function self.playcallback()
		recthelper.setAnchorX(self._txtvoicename.transform, 0)
		self:_loopVoiceName()
	end

	if isplaying then
		self:_loopVoiceName()
	else
		recthelper.setAnchorX(self._txtvoicename.transform, 0)
	end
end

function CharacterVoiceItem:_loopVoiceName()
	local maskwidth = recthelper.getWidth(self._govoicemask.transform)
	local voicewidth = recthelper.getWidth(self._txtvoicename.transform)
	local moveX = voicewidth - maskwidth

	if maskwidth < voicewidth then
		ZProj.TweenHelper.DOLocalMoveX(self._txtvoicename.transform, -moveX, self.moveduration)
		TaskDispatcher.runDelay(self.playcallback, self, self.moveduration + self.gapduration)
	end
end

function CharacterVoiceItem:_onChangeCharVoiceLang()
	self._itemAnimator.enabled = CharacterVoiceModel.instance:isNeedItemAni()

	self._itemAnimator:Play(itemShowAniName, 0, 0)
end

function CharacterVoiceItem:onDestroyView()
	return
end

return CharacterVoiceItem

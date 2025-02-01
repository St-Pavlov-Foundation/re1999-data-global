module("modules.logic.bgmswitch.view.BGMSwitchMusicItem", package.seeall)

slot0 = class("BGMSwitchMusicItem")

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._gorandom = gohelper.findChild(slot1, "random")
	slot0._imagerandombg = gohelper.findChildImage(slot1, "random/image_randombg")
	slot0._imageselect = gohelper.findChildImage(slot1, "random/randomitemselected")
	slot0._btnrandomitem = gohelper.getClickWithAudio(slot0._imagerandombg.gameObject)
	slot0._gorandomselected = gohelper.findChild(slot1, "random/randomitemselected")
	slot0._imagerandomicon = gohelper.findChildImage(slot1, "random/image_randomicon")
	slot0._txtrandom = gohelper.findChildText(slot1, "random/txt_random")
	slot0._txtrandomen = gohelper.findChildText(slot1, "random/txt_random/txt_randomEn")
	slot0._gorandommusic = gohelper.findChild(slot1, "random/randommusic")
	slot0._gonormal = gohelper.findChild(slot1, "normal")
	slot0._imagenormalbg = gohelper.findChildImage(slot1, "normal/image_normalbg")
	slot0._txtnormalname = gohelper.findChildText(slot1, "normal/txt_ItemName")
	slot0._btnlike = gohelper.findChildButton(slot1, "normal/btnlike")
	slot0._golikeBg = gohelper.findChild(slot1, "normal/btnlike/image_LikeBG")
	slot0._golike = gohelper.findChild(slot1, "normal/btnlike/golike")
	slot0._golikeEffect = gohelper.findChild(slot1, "normal/btnlike/golike/image_Like/love_select")
	slot0._gonormalselected = gohelper.findChild(slot1, "normal/normalitemselected ")
	slot0._gonormalmusic = gohelper.findChild(slot1, "normal/normalmusic")
	slot0._musicAni = slot0._gonormalmusic:GetComponent(typeof(UnityEngine.Animation))
	slot0._btnnormalitem = gohelper.getClickWithAudio(slot0._imagenormalbg.gameObject)
	slot0._itemRedDotComp = RedDotController.instance:addNotEventRedDot(gohelper.findChild(slot1, "reddot"), slot0._isNotRead, slot0)
	slot0._isSelected = false

	slot0:addEvents()
end

function slot0.addEvents(slot0)
	slot0._btnrandomitem:AddClickListener(slot0._btnrandomitemOnClick, slot0)
	slot0._btnnormalitem:AddClickListener(slot0._btnnormalitemOnClick, slot0)
	slot0._btnlike:AddClickListener(slot0._btnlikeOnClick, slot0)
	BGMSwitchController.instance:registerCallback(BGMSwitchEvent.BgmFavorite, slot0._refreshItem, slot0)
	BGMSwitchController.instance:registerCallback(BGMSwitchEvent.BgmMarkRead, slot0._bgmMarkRead, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnrandomitem:RemoveClickListener()
	slot0._btnnormalitem:RemoveClickListener()
	slot0._btnlike:RemoveClickListener()
	BGMSwitchController.instance:unregisterCallback(BGMSwitchEvent.BgmFavorite, slot0._refreshItem, slot0)
	BGMSwitchController.instance:unregisterCallback(BGMSwitchEvent.BgmMarkRead, slot0._bgmMarkRead, slot0)
end

function slot0._btnrandomitemOnClick(slot0)
	if BGMSwitchModel.instance:isRandomMode() then
		return
	end

	BGMSwitchModel.instance:setCurBgm(BGMSwitchModel.RandomBgmId)
	BGMSwitchController.instance:dispatchEvent(BGMSwitchEvent.ItemSelected)
	StatController.instance:track(StatEnum.EventName.SwitchBGM, {
		[StatEnum.EventProperties.AudioId] = "",
		[StatEnum.EventProperties.AudioName] = "",
		[StatEnum.EventProperties.BeforeSwitchAudio] = BGMSwitchConfig.instance:getBgmName(BGMSwitchModel.instance:getCurBgm()),
		[StatEnum.EventProperties.OperationType] = "click Random",
		[StatEnum.EventProperties.PlayMode] = "Random",
		[StatEnum.EventProperties.AudioSheet] = BGMSwitchConfig.instance:getBgmNames(BGMSwitchModel.instance:getCurrentUsingBgmList())
	})
	BGMSwitchAudioTrigger.play_ui_replay_tapswitch()
end

function slot0._btnnormalitemOnClick(slot0)
	slot2 = BGMSwitchModel.instance:getCurBgm()

	if not BGMSwitchModel.instance:isRandomMode() and slot2 == slot0._config.id then
		return
	end

	BGMSwitchModel.instance:setCurBgm(slot0._config.id)
	BGMSwitchController.instance:dispatchEvent(BGMSwitchEvent.ItemSelected, slot2)
	StatController.instance:track(StatEnum.EventName.SwitchBGM, {
		[StatEnum.EventProperties.AudioId] = tostring(slot0._config.id),
		[StatEnum.EventProperties.AudioName] = slot0._config.audioName,
		[StatEnum.EventProperties.BeforeSwitchAudio] = BGMSwitchConfig.instance:getBgmName(slot2),
		[StatEnum.EventProperties.OperationType] = "click Loop",
		[StatEnum.EventProperties.PlayMode] = "LoopOne",
		[StatEnum.EventProperties.AudioSheet] = BGMSwitchConfig.instance:getBgmNames(BGMSwitchModel.instance:getCurrentUsingBgmList())
	})
	BGMSwitchAudioTrigger.play_ui_replay_tapswitch()
end

function slot0._btnlikeOnClick(slot0)
	slot1 = not BGMSwitchModel.instance:isBgmFavorite(slot0._config.id)

	gohelper.setActive(slot0._golikeEffect, true)
	BgmRpc.instance:sendSetFavoriteBgmRequest(slot0._config.id, slot1)
	BGMSwitchAudioTrigger.play_ui_replay_heart(slot1)
end

function slot0.setItem(slot0, slot1)
	if not slot1 then
		slot0._random = true
	else
		slot0._random = false
		slot0._mo = slot1
		slot0._config = BGMSwitchConfig.instance:getBGMSwitchCO(slot1.bgmId)
	end

	gohelper.setActive(slot0._gorandom, slot0._random)
	gohelper.setActive(slot0._gonormal, not slot0._random)
	slot0:_refreshItem()
end

function slot0._refreshItem(slot0)
	slot0._isSelected = false

	if slot0._random then
		slot0:_setRandom()
	else
		slot0:_setNormal()
	end

	slot0:_refreshRedDot()
end

function slot0._refreshRedDot(slot0)
	if slot0._itemRedDotComp then
		slot0._itemRedDotComp:refreshRedDot()
	end
end

function slot0._bgmMarkRead(slot0, slot1)
	if not slot0._random and slot0._config and slot1 == slot0._config.id then
		slot0:_refreshRedDot()
	end
end

function slot0._isNotRead(slot0)
	return not slot0._random and slot0._mo and not slot0._mo.isRead
end

function slot0._setRandom(slot0)
	slot0._isSelected = BGMSwitchModel.instance:isRandomMode()

	gohelper.setActive(slot0._gorandomselected, slot0._isSelected)
	gohelper.setActive(slot0._gorandommusic, BGMSwitchModel.instance:isRandomBgmId(BGMSwitchModel.instance:getUsedBgmIdFromServer()) and BGMSwitchModel.instance:isLocalRemoteListTypeMatched())
end

function slot0._setNormal(slot0)
	slot0._txtnormalname.text = slot0._config.audioName
	slot0._isSelected = BGMSwitchModel.instance:getCurBgm() == slot0._config.id and BGMSwitchModel.instance:isLoopOneMode()

	gohelper.setActive(slot0._gonormalselected, slot0._isSelected)

	slot2 = BGMSwitchModel.instance:isBgmFavorite(slot0._config.id)

	gohelper.setActive(slot0._golike, slot2)
	gohelper.setActive(slot0._golikeBg, not slot2)
	gohelper.setActive(slot0._gonormalmusic, BGMSwitchModel.instance:getUsedBgmIdFromServer() == slot0._config.id and BGMSwitchModel.instance:isLocalRemoteListTypeMatched())
	UISpriteSetMgr.instance:setBgmSwitchToggleSprite(slot0._imagenormalbg, slot0._config.audioBg)

	if slot0._isSelected and slot0:_isNotRead() then
		BgmRpc.instance:sendReadBgmRequest(slot0._config.id)
	end
end

function slot0.isSelected(slot0)
	return slot0._isSelected
end

function slot0.hide(slot0, slot1)
	gohelper.setActive(slot0._golikeEffect, false)
	gohelper.setActive(slot0.go, not slot1)

	slot0._musicAni.enabled = false
end

function slot0.showSwitchEffect(slot0)
	slot0._musicAni.enabled = true

	slot0._musicAni:Play()
end

function slot0.setRandom(slot0, slot1)
	slot0._random = slot1
end

function slot0.destroy(slot0)
	slot0:removeEvents()
end

return slot0

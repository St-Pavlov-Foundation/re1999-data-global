module("modules.logic.bgmswitch.view.BGMSwitchMusicItem", package.seeall)

local var_0_0 = class("BGMSwitchMusicItem")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._gorandom = gohelper.findChild(arg_1_1, "random")
	arg_1_0._imagerandombg = gohelper.findChildImage(arg_1_1, "random/image_randombg")
	arg_1_0._imageselect = gohelper.findChildImage(arg_1_1, "random/randomitemselected")
	arg_1_0._btnrandomitem = gohelper.getClickWithAudio(arg_1_0._imagerandombg.gameObject)
	arg_1_0._gorandomselected = gohelper.findChild(arg_1_1, "random/randomitemselected")
	arg_1_0._imagerandomicon = gohelper.findChildImage(arg_1_1, "random/image_randomicon")
	arg_1_0._txtrandom = gohelper.findChildText(arg_1_1, "random/txt_random")
	arg_1_0._txtrandomen = gohelper.findChildText(arg_1_1, "random/txt_random/txt_randomEn")
	arg_1_0._gorandommusic = gohelper.findChild(arg_1_1, "random/randommusic")
	arg_1_0._gonormal = gohelper.findChild(arg_1_1, "normal")
	arg_1_0._imagenormalbg = gohelper.findChildImage(arg_1_1, "normal/image_normalbg")
	arg_1_0._txtnormalname = gohelper.findChildText(arg_1_1, "normal/txt_ItemName")
	arg_1_0._btnlike = gohelper.findChildButton(arg_1_1, "normal/btnlike")
	arg_1_0._golikeBg = gohelper.findChild(arg_1_1, "normal/btnlike/image_LikeBG")
	arg_1_0._golike = gohelper.findChild(arg_1_1, "normal/btnlike/golike")
	arg_1_0._golikeEffect = gohelper.findChild(arg_1_1, "normal/btnlike/golike/image_Like/love_select")
	arg_1_0._gonormalselected = gohelper.findChild(arg_1_1, "normal/normalitemselected ")
	arg_1_0._gonormalmusic = gohelper.findChild(arg_1_1, "normal/normalmusic")
	arg_1_0._musicAni = arg_1_0._gonormalmusic:GetComponent(typeof(UnityEngine.Animation))
	arg_1_0._btnnormalitem = gohelper.getClickWithAudio(arg_1_0._imagenormalbg.gameObject)

	local var_1_0 = gohelper.findChild(arg_1_1, "reddot")

	arg_1_0._itemRedDotComp = RedDotController.instance:addNotEventRedDot(var_1_0, arg_1_0._isNotRead, arg_1_0)
	arg_1_0._isSelected = false

	arg_1_0:addEvents()
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnrandomitem:AddClickListener(arg_2_0._btnrandomitemOnClick, arg_2_0)
	arg_2_0._btnnormalitem:AddClickListener(arg_2_0._btnnormalitemOnClick, arg_2_0)
	arg_2_0._btnlike:AddClickListener(arg_2_0._btnlikeOnClick, arg_2_0)
	BGMSwitchController.instance:registerCallback(BGMSwitchEvent.BgmFavorite, arg_2_0._refreshItem, arg_2_0)
	BGMSwitchController.instance:registerCallback(BGMSwitchEvent.BgmMarkRead, arg_2_0._bgmMarkRead, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnrandomitem:RemoveClickListener()
	arg_3_0._btnnormalitem:RemoveClickListener()
	arg_3_0._btnlike:RemoveClickListener()
	BGMSwitchController.instance:unregisterCallback(BGMSwitchEvent.BgmFavorite, arg_3_0._refreshItem, arg_3_0)
	BGMSwitchController.instance:unregisterCallback(BGMSwitchEvent.BgmMarkRead, arg_3_0._bgmMarkRead, arg_3_0)
end

function var_0_0._btnrandomitemOnClick(arg_4_0)
	if BGMSwitchModel.instance:isRandomMode() then
		return
	end

	local var_4_0 = BGMSwitchModel.instance:getCurBgm()

	BGMSwitchModel.instance:setCurBgm(BGMSwitchModel.RandomBgmId)
	BGMSwitchController.instance:dispatchEvent(BGMSwitchEvent.ItemSelected)

	local var_4_1 = BGMSwitchModel.instance:getCurrentUsingBgmList()

	StatController.instance:track(StatEnum.EventName.SwitchBGM, {
		[StatEnum.EventProperties.AudioId] = "",
		[StatEnum.EventProperties.AudioName] = "",
		[StatEnum.EventProperties.BeforeSwitchAudio] = BGMSwitchConfig.instance:getBgmName(var_4_0),
		[StatEnum.EventProperties.OperationType] = "click Random",
		[StatEnum.EventProperties.PlayMode] = "Random",
		[StatEnum.EventProperties.AudioSheet] = BGMSwitchConfig.instance:getBgmNames(var_4_1)
	})
	BGMSwitchAudioTrigger.play_ui_replay_tapswitch()
end

function var_0_0._btnnormalitemOnClick(arg_5_0)
	local var_5_0 = BGMSwitchModel.instance:isRandomMode()
	local var_5_1 = BGMSwitchModel.instance:getCurBgm()

	if not var_5_0 and var_5_1 == arg_5_0._config.id then
		return
	end

	BGMSwitchModel.instance:setCurBgm(arg_5_0._config.id)
	BGMSwitchController.instance:dispatchEvent(BGMSwitchEvent.ItemSelected, var_5_1)

	local var_5_2 = BGMSwitchModel.instance:getCurrentUsingBgmList()

	StatController.instance:track(StatEnum.EventName.SwitchBGM, {
		[StatEnum.EventProperties.AudioId] = tostring(arg_5_0._config.id),
		[StatEnum.EventProperties.AudioName] = arg_5_0._config.audioName,
		[StatEnum.EventProperties.BeforeSwitchAudio] = BGMSwitchConfig.instance:getBgmName(var_5_1),
		[StatEnum.EventProperties.OperationType] = "click Loop",
		[StatEnum.EventProperties.PlayMode] = "LoopOne",
		[StatEnum.EventProperties.AudioSheet] = BGMSwitchConfig.instance:getBgmNames(var_5_2)
	})
	BGMSwitchAudioTrigger.play_ui_replay_tapswitch()
end

function var_0_0._btnlikeOnClick(arg_6_0)
	local var_6_0 = not BGMSwitchModel.instance:isBgmFavorite(arg_6_0._config.id)

	gohelper.setActive(arg_6_0._golikeEffect, true)
	BgmRpc.instance:sendSetFavoriteBgmRequest(arg_6_0._config.id, var_6_0)
	BGMSwitchAudioTrigger.play_ui_replay_heart(var_6_0)
end

function var_0_0.setItem(arg_7_0, arg_7_1)
	if not arg_7_1 then
		arg_7_0._random = true
	else
		arg_7_0._random = false
		arg_7_0._mo = arg_7_1
		arg_7_0._config = BGMSwitchConfig.instance:getBGMSwitchCO(arg_7_1.bgmId)
	end

	gohelper.setActive(arg_7_0._gorandom, arg_7_0._random)
	gohelper.setActive(arg_7_0._gonormal, not arg_7_0._random)
	arg_7_0:_refreshItem()
end

function var_0_0._refreshItem(arg_8_0)
	arg_8_0._isSelected = false

	if arg_8_0._random then
		arg_8_0:_setRandom()
	else
		arg_8_0:_setNormal()
	end

	arg_8_0:_refreshRedDot()
end

function var_0_0._refreshRedDot(arg_9_0)
	if arg_9_0._itemRedDotComp then
		arg_9_0._itemRedDotComp:refreshRedDot()
	end
end

function var_0_0._bgmMarkRead(arg_10_0, arg_10_1)
	if not arg_10_0._random and arg_10_0._config and arg_10_1 == arg_10_0._config.id then
		arg_10_0:_refreshRedDot()
	end
end

function var_0_0._isNotRead(arg_11_0)
	return not arg_11_0._random and arg_11_0._mo and not arg_11_0._mo.isRead
end

function var_0_0._setRandom(arg_12_0)
	arg_12_0._isSelected = BGMSwitchModel.instance:isRandomMode()

	gohelper.setActive(arg_12_0._gorandomselected, arg_12_0._isSelected)

	local var_12_0 = BGMSwitchModel.instance:isRandomBgmId(BGMSwitchModel.instance:getUsedBgmIdFromServer()) and BGMSwitchModel.instance:isLocalRemoteListTypeMatched()

	gohelper.setActive(arg_12_0._gorandommusic, var_12_0)
end

function var_0_0._setNormal(arg_13_0)
	arg_13_0._txtnormalname.text = arg_13_0._config.audioName

	local var_13_0 = BGMSwitchModel.instance:isLoopOneMode()

	arg_13_0._isSelected = BGMSwitchModel.instance:getCurBgm() == arg_13_0._config.id and var_13_0

	gohelper.setActive(arg_13_0._gonormalselected, arg_13_0._isSelected)

	local var_13_1 = BGMSwitchModel.instance:isBgmFavorite(arg_13_0._config.id)

	gohelper.setActive(arg_13_0._golike, var_13_1)
	gohelper.setActive(arg_13_0._golikeBg, not var_13_1)

	local var_13_2 = BGMSwitchModel.instance:getUsedBgmIdFromServer() == arg_13_0._config.id and BGMSwitchModel.instance:isLocalRemoteListTypeMatched()

	gohelper.setActive(arg_13_0._gonormalmusic, var_13_2)
	UISpriteSetMgr.instance:setBgmSwitchToggleSprite(arg_13_0._imagenormalbg, arg_13_0._config.audioBg)

	if arg_13_0._isSelected and arg_13_0:_isNotRead() then
		BgmRpc.instance:sendReadBgmRequest(arg_13_0._config.id)
	end
end

function var_0_0.isSelected(arg_14_0)
	return arg_14_0._isSelected
end

function var_0_0.hide(arg_15_0, arg_15_1)
	gohelper.setActive(arg_15_0._golikeEffect, false)
	gohelper.setActive(arg_15_0.go, not arg_15_1)

	arg_15_0._musicAni.enabled = false
end

function var_0_0.showSwitchEffect(arg_16_0)
	arg_16_0._musicAni.enabled = true

	arg_16_0._musicAni:Play()
end

function var_0_0.setRandom(arg_17_0, arg_17_1)
	arg_17_0._random = arg_17_1
end

function var_0_0.destroy(arg_18_0)
	arg_18_0:removeEvents()
end

return var_0_0

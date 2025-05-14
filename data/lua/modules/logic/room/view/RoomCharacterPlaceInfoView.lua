module("modules.logic.room.view.RoomCharacterPlaceInfoView", package.seeall)

local var_0_0 = class("RoomCharacterPlaceInfoView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "bottom/#btn_close")
	arg_1_0._btnsure = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "bottom/#btn_sure")
	arg_1_0._txttip = gohelper.findChildText(arg_1_0.viewGO, "tip/#txt_tip")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnsure:AddClickListener(arg_2_0._btnsureOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnsure:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()

	if arg_4_0._closeCallback then
		if arg_4_0._callbackObj then
			arg_4_0._closeCallback(arg_4_0._callbackObj, arg_4_0._callbackParam)
		else
			arg_4_0._closeCallback(arg_4_0._callbackParam)
		end
	end
end

function var_0_0._btnsureOnClick(arg_5_0)
	local var_5_0 = #arg_5_0._removeHeroMOList

	if var_5_0 < arg_5_0._needRemoveCount then
		GameFacade.showToast(ToastEnum.RoomCharacterPlaceInfo, arg_5_0._needRemoveCount - var_5_0)

		return
	end

	if var_5_0 > 0 then
		if arg_5_0._notUpdateMapModel ~= true then
			for iter_5_0, iter_5_1 in ipairs(arg_5_0._removeHeroMOList) do
				RoomCharacterModel.instance:editRemoveCharacterMO(iter_5_1.heroId)
			end
		end

		local var_5_1 = {}

		for iter_5_2, iter_5_3 in ipairs(arg_5_0._currentHeroMOList) do
			local var_5_2, var_5_3 = arg_5_0:_findHeroMOById(arg_5_0._removeHeroMOList, iter_5_3.heroId)

			if not var_5_2 then
				table.insert(var_5_1, iter_5_3.heroId)
			end
		end

		RoomRpc.instance:sendUpdateRoomHeroDataRequest(var_5_1)
	end

	arg_5_0:closeThis()

	if arg_5_0._sureCallback then
		if arg_5_0._callbackObj then
			arg_5_0._sureCallback(arg_5_0._callbackObj, arg_5_0._callbackParam)
		else
			arg_5_0._sureCallback(arg_5_0._callbackParam)
		end
	end
end

function var_0_0._btnclickOnclick(arg_6_0, arg_6_1)
	local var_6_0, var_6_1 = arg_6_0:_findHeroMOById(arg_6_0._currentHeroMOList, arg_6_1)

	if var_6_0 then
		table.remove(arg_6_0._currentHeroMOList, var_6_1)
		table.insert(arg_6_0._removeHeroMOList, var_6_0)
	else
		local var_6_2, var_6_3 = arg_6_0:_findHeroMOById(arg_6_0._removeHeroMOList, arg_6_1)

		if var_6_2 then
			table.remove(arg_6_0._removeHeroMOList, var_6_3)
			table.insert(arg_6_0._currentHeroMOList, var_6_2)
		end
	end

	arg_6_0:_sort()
	arg_6_0:_refreshUI()
end

function var_0_0._findHeroMOById(arg_7_0, arg_7_1, arg_7_2)
	for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
		if iter_7_1.heroId == arg_7_2 then
			return iter_7_1, iter_7_0
		end
	end

	return nil
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0._gocurrentplacecontent = gohelper.findChild(arg_8_0.viewGO, "currentplace/#scroll_currentplace/Viewport/Content")
	arg_8_0._goremoveplacecontent = gohelper.findChild(arg_8_0.viewGO, "removeplace/#scroll_removeplace/Viewport/Content")
	arg_8_0._gotip = gohelper.findChild(arg_8_0.viewGO, "tip")

	arg_8_0._simagebg:LoadImage(ResUrl.getRoomImage("characterplace/bg_dajiandi"))
end

function var_0_0.initCharacterItem(arg_9_0)
	arg_9_0.simageicon = gohelper.findChildSingleImage(arg_9_0.go, "role/heroicon")
	arg_9_0.goclick = gohelper.findChild(arg_9_0.go, "go_click")
	arg_9_0.txttrust = gohelper.findChildText(arg_9_0.go, "trust/txt_trust")
	arg_9_0.gorole = gohelper.findChild(arg_9_0.go, "role")
	arg_9_0.imagecareer = gohelper.findChildImage(arg_9_0.go, "role/career")
	arg_9_0.imagerare = gohelper.findChildImage(arg_9_0.go, "role/rare")
	arg_9_0.txtname = gohelper.findChildText(arg_9_0.go, "role/name")
	arg_9_0.txtnameen = gohelper.findChildText(arg_9_0.go, "role/name/nameEn")
	arg_9_0.btnclick = gohelper.getClickWithAudio(arg_9_0.goclick)

	local var_9_0 = gohelper.findChild(arg_9_0.go, "trust")
	local var_9_1 = gohelper.findChild(arg_9_0.go, "placeicon")
	local var_9_2 = gohelper.findChild(arg_9_0.go, "select")
	local var_9_3 = gohelper.findChild(arg_9_0.go, "#go_onbirthdayicon")
	local var_9_4 = arg_9_0.gorole:GetComponent(typeof(UnityEngine.CanvasGroup))

	gohelper.setActive(var_9_0, true)
	gohelper.setActive(var_9_1, false)
	gohelper.setActive(var_9_2, false)
	gohelper.setActive(var_9_3, false)

	var_9_4.alpha = 1
end

function var_0_0.refreshCharacterItem(arg_10_0, arg_10_1)
	arg_10_0.simageicon:LoadImage(ResUrl.getHeadIconSmall(arg_10_1.skinConfig.headIcon))
	UISpriteSetMgr.instance:setCommonSprite(arg_10_0.imagecareer, "lssx_" .. arg_10_1.heroConfig.career)
	UISpriteSetMgr.instance:setCommonSprite(arg_10_0.imagerare, "equipbar" .. CharacterEnum.Color[arg_10_1.heroConfig.rare])

	arg_10_0.txtname.text = arg_10_1.heroConfig.name
	arg_10_0.txtnameen.text = arg_10_1.heroConfig.nameEng

	local var_10_0 = HeroModel.instance:getByHeroId(arg_10_1.heroId)
	local var_10_1 = var_10_0 and HeroConfig.instance:getFaithPercent(var_10_0.faith)[1] or 0

	arg_10_0.txttrust.text = string.format("%s%%", var_10_1 * 100)
end

function var_0_0.destroyCharacterItem(arg_11_0)
	arg_11_0.simageicon:UnLoadImage()
	arg_11_0.btnclick:RemoveClickListener()
end

function var_0_0._sort(arg_12_0)
	table.sort(arg_12_0._currentHeroMOList, function(arg_13_0, arg_13_1)
		local var_13_0 = HeroModel.instance:getByHeroId(arg_13_0.heroId)
		local var_13_1 = HeroModel.instance:getByHeroId(arg_13_1.heroId)
		local var_13_2 = var_13_0 and HeroConfig.instance:getFaithPercent(var_13_0.faith)[1] or 0
		local var_13_3 = var_13_1 and HeroConfig.instance:getFaithPercent(var_13_1.faith)[1] or 0

		if var_13_2 ~= var_13_3 then
			return var_13_3 < var_13_2
		end

		if arg_13_0.heroConfig.rare ~= arg_13_1.heroConfig.rare then
			return arg_13_0.heroConfig.rare > arg_13_1.heroConfig.rare
		end

		return arg_13_0.heroId < arg_13_1.heroId
	end)
end

function var_0_0._refreshBtnTips(arg_14_0)
	local var_14_0 = #arg_14_0._removeHeroMOList

	gohelper.setActive(arg_14_0._gotip, var_14_0 < arg_14_0._needRemoveCount)

	if var_14_0 < arg_14_0._needRemoveCount then
		arg_14_0._txttip.text = string.format(luaLang("room_character_remove_tips"), arg_14_0._needRemoveCount - var_14_0)
	end
end

function var_0_0._refreshUI(arg_15_0)
	for iter_15_0, iter_15_1 in ipairs(arg_15_0._currentHeroMOList) do
		local var_15_0 = arg_15_0._currentHeroItemList[iter_15_0]

		if not var_15_0 then
			var_15_0 = arg_15_0:getUserDataTb_()
			var_15_0.go = arg_15_0.viewContainer:getResInst(arg_15_0.viewContainer._viewSetting.otherRes[1], arg_15_0._gocurrentplacecontent, "item" .. iter_15_0)

			var_0_0.initCharacterItem(var_15_0)
			table.insert(arg_15_0._currentHeroItemList, var_15_0)
		end

		var_15_0.btnclick:RemoveClickListener()
		var_15_0.btnclick:AddClickListener(arg_15_0._btnclickOnclick, arg_15_0, iter_15_1.heroId)
		var_0_0.refreshCharacterItem(var_15_0, iter_15_1)
		gohelper.setActive(var_15_0.go, true)
	end

	for iter_15_2 = #arg_15_0._currentHeroMOList + 1, #arg_15_0._currentHeroItemList do
		local var_15_1 = arg_15_0._currentHeroItemList[iter_15_2]

		gohelper.setActive(var_15_1.go, false)
	end

	for iter_15_3, iter_15_4 in ipairs(arg_15_0._removeHeroMOList) do
		local var_15_2 = arg_15_0._removeHeroItemList[iter_15_3]

		if not var_15_2 then
			var_15_2 = arg_15_0:getUserDataTb_()
			var_15_2.go = arg_15_0.viewContainer:getResInst(arg_15_0.viewContainer._viewSetting.otherRes[1], arg_15_0._goremoveplacecontent, "item" .. iter_15_3)

			var_0_0.initCharacterItem(var_15_2)
			table.insert(arg_15_0._removeHeroItemList, var_15_2)
		end

		var_15_2.btnclick:RemoveClickListener()
		var_15_2.btnclick:AddClickListener(arg_15_0._btnclickOnclick, arg_15_0, iter_15_4.heroId)
		var_0_0.refreshCharacterItem(var_15_2, iter_15_4)
		gohelper.setActive(var_15_2.go, true)
	end

	for iter_15_5 = #arg_15_0._removeHeroMOList + 1, #arg_15_0._removeHeroItemList do
		local var_15_3 = arg_15_0._removeHeroItemList[iter_15_5]

		gohelper.setActive(var_15_3.go, false)
	end

	arg_15_0:_refreshBtnTips()
end

function var_0_0.onOpen(arg_16_0)
	arg_16_0._needRemoveCount = arg_16_0.viewParam and arg_16_0.viewParam.needRemoveCount or 0
	arg_16_0._closeCallback = arg_16_0.viewParam and arg_16_0.viewParam.closeCallback
	arg_16_0._sureCallback = arg_16_0.viewParam and arg_16_0.viewParam.sureCallback
	arg_16_0._callbackObj = arg_16_0.viewParam and arg_16_0.viewParam.callbackObj
	arg_16_0._callbackParam = arg_16_0.viewParam and arg_16_0.viewParam.callbackParam
	arg_16_0._notUpdateMapModel = arg_16_0.viewParam and arg_16_0.viewParam.notUpdateMapModel

	local var_16_0 = arg_16_0.viewParam and arg_16_0.viewParam.roomCharacterMOList or RoomCharacterModel.instance:getList()

	arg_16_0._currentHeroMOList = {}

	for iter_16_0, iter_16_1 in ipairs(var_16_0) do
		if iter_16_1:isPlaceSourceState() then
			table.insert(arg_16_0._currentHeroMOList, iter_16_1)
		end
	end

	arg_16_0._removeHeroMOList = {}
	arg_16_0._currentHeroItemList = {}
	arg_16_0._removeHeroItemList = {}

	arg_16_0:_sort()
	arg_16_0:_refreshUI()
end

function var_0_0.onClose(arg_17_0)
	return
end

function var_0_0.onDestroyView(arg_18_0)
	arg_18_0._simagebg:UnLoadImage()

	for iter_18_0, iter_18_1 in ipairs(arg_18_0._currentHeroItemList) do
		var_0_0.destroyCharacterItem(iter_18_1)
	end

	for iter_18_2, iter_18_3 in ipairs(arg_18_0._removeHeroItemList) do
		var_0_0.destroyCharacterItem(iter_18_3)
	end
end

return var_0_0

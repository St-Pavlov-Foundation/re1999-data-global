module("modules.logic.summon.view.SummonResultView", package.seeall)

local var_0_0 = class("SummonResultView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnok = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_ok")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnok:AddClickListener(arg_2_0._btnokOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnok:RemoveClickListener()
end

function var_0_0._btnokOnClick(arg_4_0)
	if arg_4_0._cantClose then
		return
	end

	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	gohelper.setActive(arg_5_0._goheroitem, false)

	arg_5_0._heroItemTables = {}

	for iter_5_0 = 1, 10 do
		local var_5_0 = arg_5_0:getUserDataTb_()

		var_5_0.go = gohelper.findChild(arg_5_0.viewGO, "herocontent/#go_heroitem" .. iter_5_0)
		var_5_0.txtname = gohelper.findChildText(var_5_0.go, "name")
		var_5_0.txtnameen = gohelper.findChildText(var_5_0.go, "nameen")
		var_5_0.imagerare = gohelper.findChildImage(var_5_0.go, "rare")
		var_5_0.equiprare = gohelper.findChildImage(var_5_0.go, "equiprare")
		var_5_0.imagecareer = gohelper.findChildImage(var_5_0.go, "career")
		var_5_0.imageequipcareer = gohelper.findChildImage(var_5_0.go, "equipcareer")
		var_5_0.goHeroIcon = gohelper.findChild(var_5_0.go, "heroicon")
		var_5_0.simageicon = gohelper.findChildSingleImage(var_5_0.go, "heroicon/icon")
		var_5_0.simageequipicon = gohelper.findChildSingleImage(var_5_0.go, "equipicon")
		var_5_0.imageicon = gohelper.findChildImage(var_5_0.go, "heroicon/icon")
		var_5_0.goeffect = gohelper.findChild(var_5_0.go, "effect")
		var_5_0.btnself = gohelper.findChildButtonWithAudio(var_5_0.go, "btn_self")
		var_5_0.goluckybag = gohelper.findChild(var_5_0.go, "luckybag")
		var_5_0.txtluckybagname = gohelper.findChildText(var_5_0.goluckybag, "name")
		var_5_0.txtluckybagnameen = gohelper.findChildText(var_5_0.goluckybag, "nameen")
		var_5_0.simageluckgbagicon = gohelper.findChildSingleImage(var_5_0.goluckybag, "icon")

		var_5_0.btnself:AddClickListener(arg_5_0.onClickItem, {
			view = arg_5_0,
			index = iter_5_0
		})
		table.insert(arg_5_0._heroItemTables, var_5_0)
	end

	arg_5_0._animation = arg_5_0.viewGO:GetComponent(typeof(UnityEngine.Animation))

	arg_5_0._animation:PlayQueued("summonresult_loop", UnityEngine.QueueMode.CompleteOthers)

	arg_5_0._cantClose = true
	arg_5_0._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 1.5, nil, arg_5_0._tweenFinish, arg_5_0, nil, EaseType.Linear)
end

function var_0_0.onDestroyView(arg_6_0)
	for iter_6_0 = 1, 10 do
		local var_6_0 = arg_6_0._heroItemTables[iter_6_0]

		if var_6_0 then
			if var_6_0.simageicon then
				var_6_0.simageicon:UnLoadImage()
			end

			if var_6_0.simageequipicon then
				var_6_0.simageequipicon:UnLoadImage()
			end

			if var_6_0.btnself then
				var_6_0.btnself:RemoveClickListener()
			end

			if var_6_0.simageluckgbagicon then
				var_6_0.simageluckgbagicon:UnLoadImage()
			end
		end
	end

	if arg_6_0._tweenId then
		ZProj.TweenHelper.KillById(arg_6_0._tweenId)
	end
end

function var_0_0.onOpen(arg_7_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_LuckDraw_TenHero_OpenAll)

	local var_7_0 = arg_7_0.viewParam.summonResultList

	arg_7_0._curPool = arg_7_0.viewParam.curPool
	arg_7_0._summonResultList = {}

	for iter_7_0, iter_7_1 in ipairs(var_7_0) do
		table.insert(arg_7_0._summonResultList, iter_7_1)
	end

	if arg_7_0._curPool then
		SummonModel.sortResult(arg_7_0._summonResultList, arg_7_0._curPool.id)
	end

	arg_7_0:_refreshUI()
	NavigateMgr.instance:addEscape(ViewName.SummonResultView, arg_7_0._btnokOnClick, arg_7_0)
end

function var_0_0.onClose(arg_8_0)
	arg_8_0:removeEventCb(SummonController.instance, SummonEvent.onSummonReply, arg_8_0.onSummonReply, arg_8_0)

	if not arg_8_0:_showCommonPropView() then
		SummonController.instance:dispatchEvent(SummonEvent.onSummonResultClose)
	end
end

function var_0_0.onCloseFinish(arg_9_0)
	return
end

function var_0_0.onClickItem(arg_10_0)
	local var_10_0 = arg_10_0.view
	local var_10_1 = arg_10_0.index
	local var_10_2 = var_10_0._summonResultList[var_10_1]

	if var_10_2.heroId and var_10_2.heroId ~= 0 then
		ViewMgr.instance:openView(ViewName.SummonHeroDetailView, {
			heroId = var_10_2.heroId
		})
	elseif var_10_2.equipId and var_10_2.equipId ~= 0 then
		EquipController.instance:openEquipView({
			equipId = var_10_2.equipId
		})
	elseif var_10_2:isLuckyBag() then
		GameFacade.showToast(ToastEnum.SummonLuckyBagGoMainViewOpen)
	end
end

function var_0_0._tweenFinish(arg_11_0)
	arg_11_0._cantClose = false
end

function var_0_0.onSummonReply(arg_12_0)
	arg_12_0:closeThis()
end

function var_0_0._refreshUI(arg_13_0)
	for iter_13_0 = 1, #arg_13_0._summonResultList do
		local var_13_0 = arg_13_0._summonResultList[iter_13_0]

		if var_13_0.heroId and var_13_0.heroId ~= 0 then
			arg_13_0:_refreshHeroItem(arg_13_0._heroItemTables[iter_13_0], var_13_0)
		elseif var_13_0.equipId and var_13_0.equipId ~= 0 then
			arg_13_0:_refreshEquipItem(arg_13_0._heroItemTables[iter_13_0], var_13_0)
		elseif var_13_0:isLuckyBag() then
			arg_13_0:_refreshLuckyBagItem(arg_13_0._heroItemTables[iter_13_0], var_13_0)
		else
			gohelper.setActive(arg_13_0._heroItemTables[iter_13_0].go, false)
		end
	end

	for iter_13_1 = #arg_13_0._summonResultList + 1, #arg_13_0._heroItemTables do
		gohelper.setActive(arg_13_0._heroItemTables[iter_13_1].go, false)
	end
end

local function var_0_1(arg_14_0)
	if not gohelper.isNil(arg_14_0.imageicon) then
		arg_14_0.imageicon:SetNativeSize()
	end
end

function var_0_0._refreshEquipItem(arg_15_0, arg_15_1, arg_15_2)
	gohelper.setActive(arg_15_1.goHeroIcon, false)
	gohelper.setActive(arg_15_1.simageequipicon.gameObject, true)
	gohelper.setActive(arg_15_1.goluckybag, false)
	gohelper.setActive(arg_15_1.txtname, true)

	local var_15_0 = GameConfig:GetCurLangType() == LangSettings.zh

	gohelper.setActive(arg_15_1.txtnameen, var_15_0)

	local var_15_1 = arg_15_2.equipId
	local var_15_2 = EquipConfig.instance:getEquipCo(var_15_1)

	arg_15_1.txtname.text = var_15_2.name
	arg_15_1.txtnameen.text = var_15_2.name_en

	UISpriteSetMgr.instance:setSummonSprite(arg_15_1.imagerare, "pingzhi_" .. tostring(CharacterEnum.Color[var_15_2.rare]))
	UISpriteSetMgr.instance:setSummonSprite(arg_15_1.equiprare, "equiprare_" .. tostring(CharacterEnum.Color[var_15_2.rare]))
	gohelper.setActive(arg_15_1.imagecareer.gameObject, false)
	gohelper.setActive(arg_15_1.simageicon.gameObject, false)
	arg_15_1.simageequipicon:LoadImage(ResUrl.getSummonEquipGetIcon(var_15_2.icon), var_0_1, arg_15_1)
	EquipHelper.loadEquipCareerNewIcon(var_15_2, arg_15_1.imageequipcareer, 1, "lssx")
	arg_15_0:_refreshEffect(var_15_2.rare, arg_15_1)
	gohelper.setActive(arg_15_1.go, true)
end

function var_0_0._refreshHeroItem(arg_16_0, arg_16_1, arg_16_2)
	gohelper.setActive(arg_16_1.imageequipcareer.gameObject, false)
	gohelper.setActive(arg_16_1.goHeroIcon, true)
	gohelper.setActive(arg_16_1.goluckybag, false)
	gohelper.setActive(arg_16_1.txtname, true)

	local var_16_0 = GameConfig:GetCurLangType() == LangSettings.zh

	gohelper.setActive(arg_16_1.txtnameen, var_16_0)

	local var_16_1 = arg_16_2.heroId
	local var_16_2 = HeroConfig.instance:getHeroCO(var_16_1)
	local var_16_3 = SkinConfig.instance:getSkinCo(var_16_2.skinId)

	gohelper.setActive(arg_16_1.equiprare.gameObject, false)
	gohelper.setActive(arg_16_1.simageequipicon.gameObject, false)

	arg_16_1.txtname.text = var_16_2.name
	arg_16_1.txtnameen.text = var_16_2.nameEng

	UISpriteSetMgr.instance:setSummonSprite(arg_16_1.imagerare, "pingzhi_" .. tostring(CharacterEnum.Color[var_16_2.rare]))
	UISpriteSetMgr.instance:setCommonSprite(arg_16_1.imagecareer, "lssx_" .. tostring(var_16_2.career))
	arg_16_1.simageicon:LoadImage(ResUrl.getHeadIconMiddle(var_16_3.retangleIcon))

	if arg_16_1.effect then
		gohelper.destroy(arg_16_1.effect)

		arg_16_1.effect = nil
	end

	arg_16_0:_refreshEffect(var_16_2.rare, arg_16_1)
	gohelper.setActive(arg_16_1.go, true)
end

function var_0_0._refreshLuckyBagItem(arg_17_0, arg_17_1, arg_17_2)
	gohelper.setActive(arg_17_1.goluckybag, true)
	gohelper.setActive(arg_17_1.equiprare.gameObject, false)
	gohelper.setActive(arg_17_1.simageequipicon.gameObject, false)
	gohelper.setActive(arg_17_1.imagecareer.gameObject, false)
	gohelper.setActive(arg_17_1.simageicon.gameObject, false)
	gohelper.setActive(arg_17_1.txtname, false)
	gohelper.setActive(arg_17_1.txtnameen, false)

	local var_17_0 = arg_17_2.luckyBagId

	if not arg_17_0._curPool then
		return
	end

	local var_17_1 = SummonConfig.instance:getLuckyBag(arg_17_0._curPool.id, var_17_0)

	arg_17_1.txtluckybagname.text = var_17_1.name
	arg_17_1.txtluckybagnameen.text = var_17_1.nameEn or ""

	arg_17_1.simageluckgbagicon:LoadImage(ResUrl.getSummonCoverBg(var_17_1.icon))
	UISpriteSetMgr.instance:setSummonSprite(arg_17_1.imagerare, "pingzhi_" .. tostring(CharacterEnum.Color[SummonEnum.LuckyBagRare]))
	arg_17_0:_refreshEffect(SummonEnum.LuckyBagRare, arg_17_1)
	gohelper.setActive(arg_17_1.go, true)
end

function var_0_0._refreshEffect(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0

	if arg_18_1 == 3 then
		var_18_0 = arg_18_0.viewContainer:getSetting().otherRes[1]
	elseif arg_18_1 == 4 then
		var_18_0 = arg_18_0.viewContainer:getSetting().otherRes[2]
	elseif arg_18_1 == 5 then
		var_18_0 = arg_18_0.viewContainer:getSetting().otherRes[3]
	end

	if var_18_0 then
		arg_18_2.effect = arg_18_0.viewContainer:getResInst(var_18_0, arg_18_2.goeffect, "effect")

		arg_18_2.effect:GetComponent(typeof(UnityEngine.Animation)):PlayQueued("ssr_loop", UnityEngine.QueueMode.CompleteOthers)
	end
end

function var_0_0.onUpdateParam(arg_19_0)
	local var_19_0 = arg_19_0.viewParam.summonResultList

	arg_19_0._summonResultList = {}
	arg_19_0._curPool = arg_19_0.viewParam.curPool

	for iter_19_0, iter_19_1 in ipairs(var_19_0) do
		table.insert(arg_19_0._summonResultList, iter_19_1)
	end

	if arg_19_0._curPool then
		SummonModel.sortResult(arg_19_0._summonResultList, arg_19_0._curPool.id)
	end

	arg_19_0:_refreshUI()
end

function var_0_0._showCommonPropView(arg_20_0)
	if GuideController.instance:isGuiding() and GuideModel.instance:getDoingGuideId() == 102 then
		return false
	end

	local var_20_0 = SummonModel.getRewardList(arg_20_0._summonResultList)

	if arg_20_0._curPool and arg_20_0._curPool.ticketId ~= 0 then
		SummonModel.appendRewardTicket(arg_20_0._summonResultList, var_20_0, arg_20_0._curPool.ticketId)
	end

	if #var_20_0 <= 0 then
		return false
	end

	table.sort(var_20_0, SummonModel.sortRewards)
	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, var_20_0)

	return true
end

return var_0_0

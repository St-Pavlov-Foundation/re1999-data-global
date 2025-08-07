module("modules.logic.character.view.extra.CharacterDefaultExtraView", package.seeall)

local var_0_0 = class("CharacterDefaultExtraView", BaseView)
local var_0_1 = 0
local var_0_2 = 1

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goskillLayout = gohelper.findChild(arg_1_0.viewGO, "anim/layout/#go_skillLayout")
	arg_1_0._goweapon = gohelper.findChild(arg_1_0._goskillLayout, "#go_weapon")
	arg_1_0._goweaponmain = gohelper.findChild(arg_1_0._goweapon, "main")
	arg_1_0._imageweaponmainicon = gohelper.findChildImage(arg_1_0._goweapon, "main/#image_icon")
	arg_1_0._goweaponmainadd = gohelper.findChild(arg_1_0._goweapon, "main/#go_add")
	arg_1_0._goweaponmainreddot = gohelper.findChild(arg_1_0._goweapon, "main/#go_reddot")
	arg_1_0._goweaponsecond = gohelper.findChild(arg_1_0._goweapon, "second")
	arg_1_0._imageweaponsecondicon = gohelper.findChildImage(arg_1_0._goweapon, "second/#image_icon")
	arg_1_0._goweaponsecondadd = gohelper.findChild(arg_1_0._goweapon, "second/#go_add")
	arg_1_0._goweaponsecondreddot = gohelper.findChild(arg_1_0._goweapon, "second/#go_reddot")
	arg_1_0._btnweapon = gohelper.findChildButtonWithAudio(arg_1_0._goweapon, "#btn_weapon")
	arg_1_0._goskilltalent = gohelper.findChild(arg_1_0._goskillLayout, "#go_skilltalent")
	arg_1_0._goskilltalentlock = gohelper.findChild(arg_1_0._goskillLayout, "#go_skilltalent/lock")
	arg_1_0._goskilltalentunlight = gohelper.findChild(arg_1_0._goskillLayout, "#go_skilltalent/unlight")
	arg_1_0._goskilltalentunlightreddot = gohelper.findChild(arg_1_0._goskilltalent, "unlight/#go_reddot")
	arg_1_0._goskilltalentlightedreddot = gohelper.findChild(arg_1_0._goskilltalent, "lighted/#go_reddot")
	arg_1_0._goskilltalentlighted = gohelper.findChild(arg_1_0._goskillLayout, "#go_skilltalent/lighted")
	arg_1_0._btnskilltalent = gohelper.findChildButtonWithAudio(arg_1_0._goskilltalent, "#btn_skilltalent")
	arg_1_0._goskill = gohelper.findChild(arg_1_0._goskilltalent, "#go_skillLayout/#go_skill")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnweapon:AddClickListener(arg_2_0._btnweaponOnClick, arg_2_0)
	arg_2_0._btnskilltalent:AddClickListener(arg_2_0._btnskilltalentOnClick, arg_2_0)
	arg_2_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroRankUp, arg_2_0._onSuccessHeroRankUp, arg_2_0)
	arg_2_0:addEventCb(CharacterController.instance, CharacterEvent.onChoiceHero3123WeaponReply, arg_2_0._refreshWeapon, arg_2_0)
	arg_2_0:addEventCb(CharacterController.instance, CharacterEvent.onChoiceHero3124TalentTreeReply, arg_2_0._refresSkilltalent, arg_2_0)
	arg_2_0:addEventCb(CharacterController.instance, CharacterEvent.onResetHero3124TalentTreeReply, arg_2_0._refresSkilltalent, arg_2_0)
	arg_2_0:addEventCb(CharacterController.instance, CharacterEvent.onCancelHero3124TalentTreeReply, arg_2_0._refresSkilltalent, arg_2_0)
	arg_2_0:addEventCb(OdysseyController.instance, OdysseyEvent.TrialTalentTreeChange, arg_2_0._refresSkilltalent, arg_2_0)
	arg_2_0:addEventCb(OdysseyController.instance, OdysseyEvent.TrialTalentTreeReset, arg_2_0._refresSkilltalent, arg_2_0)
	arg_2_0:addEventCb(CharacterController.instance, CharacterEvent.OnSwitchSpine, arg_2_0._onSwitchSpine, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseFullView, arg_2_0._onCloseFullView, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnweapon:RemoveClickListener()
	arg_3_0._btnskilltalent:RemoveClickListener()
	arg_3_0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroRankUp, arg_3_0._onSuccessHeroRankUp, arg_3_0)
	arg_3_0:removeEventCb(CharacterController.instance, CharacterEvent.onChoiceHero3123WeaponReply, arg_3_0._refreshWeapon, arg_3_0)
	arg_3_0:removeEventCb(CharacterController.instance, CharacterEvent.onChoiceHero3124TalentTreeReply, arg_3_0._refresSkilltalent, arg_3_0)
	arg_3_0:removeEventCb(CharacterController.instance, CharacterEvent.onResetHero3124TalentTreeReply, arg_3_0._refresSkilltalent, arg_3_0)
	arg_3_0:removeEventCb(CharacterController.instance, CharacterEvent.onCancelHero3124TalentTreeReply, arg_3_0._refresSkilltalent, arg_3_0)
	arg_3_0:removeEventCb(OdysseyController.instance, OdysseyEvent.TrialTalentTreeChange, arg_3_0._refresSkilltalent, arg_3_0)
	arg_3_0:removeEventCb(OdysseyController.instance, OdysseyEvent.TrialTalentTreeReset, arg_3_0._refresSkilltalent, arg_3_0)
	arg_3_0:removeEventCb(CharacterController.instance, CharacterEvent.OnSwitchSpine, arg_3_0._onSwitchSpine, arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseFullView, arg_3_0._onCloseFullView, arg_3_0)
end

function var_0_0._btnweaponOnClick(arg_4_0)
	if not arg_4_0.weaponMo then
		return
	end

	if not arg_4_0.weaponMo:isUnlockSystem() then
		local var_4_0 = arg_4_0.weaponMo:getUnlockSystemRank()

		GameFacade.showToast(ToastEnum.CharacterRankUnlock, GameUtil.getNum2Chinese(var_4_0 - 1))

		return
	end

	CharacterController.instance:openCharacterWeaponView(arg_4_0.heroMo)
	arg_4_0.weaponMo:checkReddot()
	arg_4_0:_refreshWeaponReddot()
end

function var_0_0._btnskilltalentOnClick(arg_5_0)
	if not arg_5_0.skillTalentMo then
		return
	end

	if not arg_5_0.skillTalentMo:isUnlockSystem() then
		local var_5_0 = arg_5_0.skillTalentMo:getUnlockSystemRank()

		GameFacade.showToast(ToastEnum.CharacterRankUnlock, GameUtil.getNum2Chinese(var_5_0 - 1))

		return
	end

	CharacterController.instance:openCharacterSkillTalentView(arg_5_0.heroMo)
end

function var_0_0._editableInitView(arg_6_0)
	local var_6_0 = arg_6_0._goweaponmain:GetComponent(typeof(UnityEngine.Animator))
	local var_6_1 = arg_6_0._goweaponsecond:GetComponent(typeof(UnityEngine.Animator))

	arg_6_0._weaponComps = {
		[CharacterExtraEnum.WeaponType.First] = {
			Root = arg_6_0._goweaponmain,
			Icon = arg_6_0._imageweaponmainicon,
			Add = arg_6_0._goweaponmainadd,
			Reddot = arg_6_0._goweaponmainreddot,
			Anim = var_6_0
		},
		[CharacterExtraEnum.WeaponType.Second] = {
			Root = arg_6_0._goweaponsecond,
			Icon = arg_6_0._imageweaponsecondicon,
			Add = arg_6_0._goweaponsecondadd,
			Reddot = arg_6_0._goweaponsecondreddot,
			Anim = var_6_1
		}
	}
	arg_6_0._skilltalentitems = arg_6_0:getUserDataTb_()

	for iter_6_0 = 1, 3 do
		local var_6_2 = gohelper.findChild(arg_6_0._goskilltalent, "lighted/" .. iter_6_0)

		if var_6_2 then
			local var_6_3 = arg_6_0:getUserDataTb_()

			var_6_3.go = var_6_2
			var_6_3.iconList = arg_6_0:getUserDataTb_()
			var_6_3.numList = arg_6_0:getUserDataTb_()

			if iter_6_0 > 1 then
				for iter_6_1 = 1, iter_6_0 do
					var_6_3.iconList[iter_6_1] = gohelper.findChildImage(var_6_2, "#image_icon" .. iter_6_1)
					var_6_3.numList[iter_6_1] = gohelper.findChildText(var_6_2, "#txt_num" .. iter_6_1)
				end
			else
				var_6_3.iconList[1] = gohelper.findChildImage(var_6_2, "#image_icon")
				var_6_3.numList[1] = gohelper.findChildText(var_6_2, "#txt_num")
			end

			arg_6_0._skilltalentitems[iter_6_0] = var_6_3
		end
	end
end

function var_0_0._onSuccessHeroRankUp(arg_7_0)
	arg_7_0:_refreshView()
end

function var_0_0._onSwitchSpine(arg_8_0, arg_8_1)
	arg_8_0:_refreshMo(arg_8_1)
end

function var_0_0._onCloseFullView(arg_9_0, arg_9_1)
	if arg_9_1 == ViewName.CharacterRankUpResultView then
		arg_9_0:_checkPlayUnlockWeaponAnim()
	elseif arg_9_1 == ViewName.CharacterWeaponView then
		arg_9_0:_checkPlaySwitchWeaponAnim(true)
	end
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0:_refreshMo(arg_10_0.viewParam)
end

function var_0_0._refreshMo(arg_11_0, arg_11_1)
	arg_11_0.heroMo = arg_11_1
	arg_11_0.heroExtraMo = arg_11_0.heroMo.extraMo
	arg_11_0.weaponMo = arg_11_0.heroExtraMo and arg_11_0.heroExtraMo:getWeaponMo()
	arg_11_0.skillTalentMo = arg_11_0.heroExtraMo and (arg_11_0.heroMo.trialCo and OdysseyTalentModel.instance:getTrialCassandraTreeInfo() or arg_11_0.heroExtraMo:getSkillTalentMo())

	arg_11_0:_refreshEntrance()
	arg_11_0:_refreshView()
	arg_11_0:_checkPlayUnlockWeaponAnim()
	arg_11_0:_checkPlaySwitchWeaponAnim(false)
end

function var_0_0._refreshView(arg_12_0)
	if arg_12_0.weaponMo then
		arg_12_0:_refreshWeapon()
	end

	if arg_12_0.skillTalentMo then
		arg_12_0:_refresSkilltalent()
	else
		gohelper.setActive(arg_12_0._goskilltalentlightedreddot, false)
		gohelper.setActive(arg_12_0._goskilltalentunlightreddot, false)
	end

	arg_12_0:_refreshWeaponReddot()
end

function var_0_0._refreshWeaponReddot(arg_13_0)
	for iter_13_0, iter_13_1 in ipairs(arg_13_0._weaponComps) do
		local var_13_0 = iter_13_1.Reddot
		local var_13_1 = arg_13_0.weaponMo and arg_13_0.weaponMo:isShowWeaponReddot(iter_13_0)

		gohelper.setActive(var_13_0, var_13_1)
	end
end

function var_0_0._refreshEntrance(arg_14_0)
	local var_14_0 = arg_14_0.heroExtraMo and arg_14_0.heroExtraMo:hasTalentSkill()
	local var_14_1 = arg_14_0.heroExtraMo and arg_14_0.heroExtraMo:hasWeapon()

	gohelper.setActive(arg_14_0._goweapon, var_14_1)
	gohelper.setActive(arg_14_0._goskilltalent, var_14_0)
end

function var_0_0._refreshWeapon(arg_15_0)
	if arg_15_0.weaponMo then
		for iter_15_0, iter_15_1 in ipairs(arg_15_0._weaponComps) do
			local var_15_0 = arg_15_0.weaponMo:isUnlockWeapon(iter_15_0)

			if var_15_0 then
				local var_15_1 = arg_15_0.weaponMo:getCurEquipWeapon(iter_15_0)
				local var_15_2 = var_15_1 and var_15_1 ~= 0

				if var_15_2 then
					local var_15_3 = arg_15_0.weaponMo:getWeaponMoByTypeId(iter_15_0, var_15_1)
					local var_15_4 = iter_15_0 == CharacterExtraEnum.WeaponType.First and var_15_3.co.firsticon or var_15_3.co.secondicon

					if not string.nilorempty(var_15_4) then
						UISpriteSetMgr.instance:setUiCharacterSprite(iter_15_1.Icon, var_15_4)
					end
				end

				gohelper.setActive(iter_15_1.Icon.gameObject, var_15_2)
				gohelper.setActive(iter_15_1.Add, not var_15_2)
			end

			gohelper.setActive(iter_15_1.Root, var_15_0)
		end
	end
end

function var_0_0._checkPlayUnlockWeaponAnim(arg_16_0)
	if arg_16_0.weaponMo then
		for iter_16_0, iter_16_1 in ipairs(arg_16_0._weaponComps) do
			if arg_16_0.weaponMo:isUnlockWeapon(iter_16_0) then
				local var_16_0 = arg_16_0:_getPlayUnlockWeaponAnimKey(iter_16_0)

				if GameUtil.playerPrefsGetNumberByUserId(var_16_0, var_0_1) == var_0_1 then
					iter_16_1.Anim:Play(CharacterExtraEnum.WeaponAnimName.Unlock, 0, 0)
					GameUtil.playerPrefsSetNumberByUserId(arg_16_0:_getPlayUnlockWeaponAnimKey(iter_16_0), var_0_2)
					AudioMgr.instance:trigger(AudioEnum2_9.Character.ui_role_aijiao_jiesuo2)
				end
			end
		end
	end
end

function var_0_0._checkPlaySwitchWeaponAnim(arg_17_0, arg_17_1)
	if arg_17_0.weaponMo then
		if not arg_17_0._showWeaponId then
			arg_17_0._showWeaponId = {}
		end

		for iter_17_0, iter_17_1 in ipairs(arg_17_0._weaponComps) do
			if arg_17_0.weaponMo:isUnlockWeapon(iter_17_0) then
				local var_17_0 = arg_17_0.weaponMo:getCurEquipWeapon(iter_17_0)

				if (arg_17_0._showWeaponId[iter_17_0] or 0) ~= var_17_0 then
					arg_17_0._showWeaponId[iter_17_0] = var_17_0

					if arg_17_1 then
						iter_17_1.Anim:Play(CharacterExtraEnum.WeaponAnimName.Switch, 0, 0)
					end
				end
			end
		end
	end
end

function var_0_0._getPlayUnlockWeaponAnimKey(arg_18_0, arg_18_1)
	return (string.format("CharacterDefaultExtraView_PlayWeaponAnimKey_%s_%s", arg_18_0.heroMo.heroId, arg_18_1))
end

function var_0_0._refresSkilltalent(arg_19_0)
	local var_19_0 = arg_19_0.skillTalentMo:isUnlockSystem()

	gohelper.setActive(arg_19_0._goskilltalentlightedreddot, arg_19_0.skillTalentMo:showReddot())
	gohelper.setActive(arg_19_0._goskilltalentunlightreddot, arg_19_0.skillTalentMo:showReddot())

	if var_19_0 then
		local var_19_1 = arg_19_0.skillTalentMo:isNotLight()

		if not var_19_1 then
			local var_19_2 = arg_19_0.skillTalentMo:getSubExtra()
			local var_19_3 = {}
			local var_19_4 = 0

			for iter_19_0, iter_19_1 in pairs(var_19_2) do
				local var_19_5 = {
					sub = iter_19_0,
					count = tabletool.len(iter_19_1)
				}

				table.insert(var_19_3, var_19_5)

				var_19_4 = var_19_4 + 1
			end

			table.sort(var_19_3, function(arg_20_0, arg_20_1)
				return arg_20_0.count > arg_20_1.count
			end)

			local var_19_6 = arg_19_0._skilltalentitems[var_19_4]

			if var_19_6 then
				for iter_19_2 = 1, var_19_4 do
					var_19_6.numList[iter_19_2].text = var_19_3[iter_19_2].count

					local var_19_7 = var_19_6.iconList[iter_19_2]
					local var_19_8 = arg_19_0.skillTalentMo:getWhiteSubIconPath(var_19_3[iter_19_2].sub)

					UISpriteSetMgr.instance:setUiCharacterSprite(var_19_7, var_19_8)
				end
			end

			for iter_19_3, iter_19_4 in ipairs(arg_19_0._skilltalentitems) do
				gohelper.setActive(iter_19_4.go, var_19_4 == iter_19_3)
			end
		end

		gohelper.setActive(arg_19_0._goskilltalentlock, false)
		gohelper.setActive(arg_19_0._goskilltalentunlight, var_19_1)
		gohelper.setActive(arg_19_0._goskilltalentlighted, not var_19_1)
	else
		gohelper.setActive(arg_19_0._goskilltalentlock, true)
		gohelper.setActive(arg_19_0._goskilltalentunlight, false)
		gohelper.setActive(arg_19_0._goskilltalentlighted, false)
	end
end

return var_0_0

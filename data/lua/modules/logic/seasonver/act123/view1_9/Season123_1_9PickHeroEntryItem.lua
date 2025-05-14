module("modules.logic.seasonver.act123.view1_9.Season123_1_9PickHeroEntryItem", package.seeall)

local var_0_0 = class("Season123_1_9PickHeroEntryItem", UserDataDispose)

function var_0_0.ctor(arg_1_0)
	arg_1_0:__onInit()
end

function var_0_0.dispose(arg_2_0)
	arg_2_0:removeEvents()
	arg_2_0:__onDispose()
end

function var_0_0.init(arg_3_0, arg_3_1)
	arg_3_0.viewGO = gohelper.findChild(arg_3_1, "root")

	arg_3_0:initComponent()
end

var_0_0.exSkillFillAmount = {
	0.2,
	0.4,
	0.6,
	0.79,
	1
}
var_0_0.MaxRare = 5

function var_0_0.initComponent(arg_4_0)
	arg_4_0._goadd = gohelper.findChild(arg_4_0.viewGO, "#go_add")
	arg_4_0._gohero = gohelper.findChild(arg_4_0.viewGO, "#go_hero")
	arg_4_0._goassist = gohelper.findChild(arg_4_0.viewGO, "#go_assit")
	arg_4_0._simageicon = gohelper.findChildSingleImage(arg_4_0._gohero, "#simage_rolehead")
	arg_4_0._txtlevel = gohelper.findChildText(arg_4_0._gohero, "#txt_roleLv1")
	arg_4_0._txttalentevel2 = gohelper.findChildText(arg_4_0._gohero, "#txt_roleLv2")
	arg_4_0._goexskill = gohelper.findChild(arg_4_0._gohero, "#go_exskill")
	arg_4_0._imageexskill = gohelper.findChildImage(arg_4_0._gohero, "#go_exskill/#image_exskill")
	arg_4_0._imagecareer = gohelper.findChildImage(arg_4_0._gohero, "career")
	arg_4_0._btnclick = gohelper.findChildButtonWithAudio(arg_4_0.viewGO, "btn_click")
	arg_4_0._btnselfsupport = gohelper.findChildButtonWithAudio(arg_4_0.viewGO, "#btn_selfassit")
	arg_4_0._btnothersupport = gohelper.findChildButtonWithAudio(arg_4_0.viewGO, "#btn_otherassit")
	arg_4_0._txtrolename = gohelper.findChildText(arg_4_0._gohero, "#txt_rolename")
	arg_4_0._gotalentline = gohelper.findChild(arg_4_0._gohero, "line")
	arg_4_0._gosliderhp = gohelper.findChild(arg_4_0.viewGO, "#slider_hp")
	arg_4_0._gorank = gohelper.findChild(arg_4_0._gohero, "rank")
	arg_4_0._gocuthero = gohelper.findChild(arg_4_0.viewGO, "#click")
	arg_4_0._animCuthero = gohelper.findChild(arg_4_0._gocuthero, "ani"):GetComponent(typeof(UnityEngine.Animator))
	arg_4_0._rankList = arg_4_0:getUserDataTb_()

	local var_4_0 = HeroConfig.instance:getMaxRank(var_0_0.MaxRare)

	for iter_4_0 = 1, var_4_0 do
		arg_4_0._rankList[iter_4_0] = gohelper.findChild(arg_4_0._gorank, "rank" .. tostring(iter_4_0))
	end

	arg_4_0._gorare = gohelper.findChild(arg_4_0._gohero, "rare")
	arg_4_0._rareList = arg_4_0:getUserDataTb_()

	for iter_4_1 = 1, CharacterEnum.MaxRare + 1 do
		arg_4_0._rareList[iter_4_1] = gohelper.findChild(arg_4_0._gorare, "go_rare" .. tostring(iter_4_1))
	end

	arg_4_0._btnclick:AddClickListener(arg_4_0.onClickSelf, arg_4_0)
	arg_4_0._btnselfsupport:AddClickListener(arg_4_0.onClickSupport, arg_4_0)
	arg_4_0._btnothersupport:AddClickListener(arg_4_0.onClickSupport, arg_4_0)
end

function var_0_0.removeEvents(arg_5_0)
	arg_5_0._btnclick:RemoveClickListener()
	arg_5_0._btnselfsupport:RemoveClickListener()
	arg_5_0._btnothersupport:RemoveClickListener()
	TaskDispatcher.cancelTask(arg_5_0.playOpenAnim, arg_5_0)
end

function var_0_0.initData(arg_6_0, arg_6_1)
	arg_6_0._index = arg_6_1

	arg_6_0:refreshUI()
	arg_6_0:OpenAnim()
end

function var_0_0.refreshUI(arg_7_0)
	local var_7_0 = Season123PickHeroEntryModel.instance:getByIndex(arg_7_0._index)

	if var_7_0 then
		local var_7_1 = var_7_0:getIsEmpty()

		gohelper.setActive(arg_7_0._goadd, var_7_1)
		gohelper.setActive(arg_7_0._gohero, not var_7_1)

		if not var_7_1 then
			if var_7_0.heroMO and var_7_0.heroMO.config then
				arg_7_0._txtrolename.text = var_7_0.heroMO.config.name

				UISpriteSetMgr.instance:setCommonSprite(arg_7_0._imagecareer, "lssx_" .. tostring(var_7_0.heroMO.config.career))
			else
				arg_7_0._txtrolename.text = ""

				gohelper.setActive(arg_7_0._imagecareer, false)
			end

			arg_7_0:refreshRare(var_7_0.heroMO)
			arg_7_0:refreshRank(var_7_0.heroMO)
			arg_7_0:refreshExSkill(var_7_0.heroMO)

			if var_7_0.heroMO then
				local var_7_2 = SkinConfig.instance:getSkinCo(var_7_0.heroMO.skin)

				if not var_7_2 then
					logError("Season123_1_9PickHeroEntryItem.refreshUI error, skinCfg is nil, id:" .. tostring(var_7_0.skinId))

					return
				end

				arg_7_0._simageicon:LoadImage(ResUrl.getRoomHeadIcon(var_7_2.headIcon))

				arg_7_0._txtlevel.text = "Lv." .. tostring(HeroConfig.instance:getShowLevel(var_7_0.heroMO.level))

				local var_7_3 = false

				if var_7_0.heroMO:isOtherPlayerHero() then
					var_7_3 = var_7_0.heroMO:getOtherPlayerIsOpenTalent()
				else
					local var_7_4 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Talent)
					local var_7_5 = var_7_0.heroMO.rank >= CharacterEnum.TalentRank

					var_7_3 = var_7_4 and var_7_5
				end

				if var_7_3 then
					gohelper.setActive(arg_7_0._gotalentline, true)
					gohelper.setActive(arg_7_0._txttalentevel2, true)

					arg_7_0._txttalentevel2.text = "Lv." .. tostring(var_7_0.heroMO.talent)
				else
					gohelper.setActive(arg_7_0._gotalentline, false)
					gohelper.setActive(arg_7_0._txttalentevel2, false)
				end
			else
				arg_7_0._txtlevel.text = ""

				gohelper.setActive(arg_7_0._gotalentline, false)
				gohelper.setActive(arg_7_0._txttalentevel2, false)
			end
		end
	end

	local var_7_6 = arg_7_0._index == Activity123Enum.SupportPosIndex

	if var_7_6 then
		gohelper.setActive(arg_7_0._goassist, var_7_6 and var_7_0 and var_7_0.isSupport)
		gohelper.setActive(arg_7_0._btnselfsupport, var_7_0 and (not var_7_0.isSupport or var_7_0:getIsEmpty()))
		gohelper.setActive(arg_7_0._btnothersupport, var_7_0 and var_7_0.isSupport)
	else
		gohelper.setActive(arg_7_0._goassist, false)
		gohelper.setActive(arg_7_0._btnselfsupport, false)
		gohelper.setActive(arg_7_0._btnothersupport, false)
	end
end

function var_0_0.refreshRare(arg_8_0, arg_8_1)
	for iter_8_0 = 1, #arg_8_0._rareList do
		gohelper.setActive(arg_8_0._rareList[iter_8_0], iter_8_0 <= arg_8_1.config.rare + 1)
	end
end

function var_0_0.refreshRank(arg_9_0, arg_9_1)
	if arg_9_1 and arg_9_1.rank and arg_9_1.rank > 1 then
		gohelper.setActive(arg_9_0._gorank, true)

		local var_9_0 = 5

		for iter_9_0 = 1, var_9_0 do
			gohelper.setActive(arg_9_0._rankList[iter_9_0], arg_9_1.rank - 1 == iter_9_0)
		end
	else
		gohelper.setActive(arg_9_0._gorank, false)
	end
end

function var_0_0.refreshExSkill(arg_10_0, arg_10_1)
	if arg_10_1.exSkillLevel <= 0 then
		arg_10_0._imageexskill.fillAmount = 0

		return
	end

	gohelper.setActive(arg_10_0._goexskill, true)

	arg_10_0._imageexskill.fillAmount = SummonCustomPickChoiceItem.exSkillFillAmount[arg_10_1.exSkillLevel] or 1
end

function var_0_0.onClickSelf(arg_11_0)
	logNormal("onClickSelf ： " .. tostring(arg_11_0._index))

	if arg_11_0._index == Activity123Enum.SupportPosIndex and Season123PickHeroEntryModel.instance:getByIndex(arg_11_0._index).isSupport then
		Season123PickHeroEntryController.instance:openPickSupportView()

		return
	end

	Season123PickHeroEntryController.instance:openPickHeroView(arg_11_0._index)
end

function var_0_0.onClickSupport(arg_12_0)
	if arg_12_0._index == Activity123Enum.SupportPosIndex then
		if Season123PickHeroEntryModel.instance:getByIndex(arg_12_0._index).isSupport then
			GameFacade.showMessageBox(MessageBoxIdDefine.Season123CancelAssist, MsgBoxEnum.BoxType.Yes_No, Season123PickHeroEntryController.instance.cancelSupport, nil, nil, Season123PickHeroEntryController.instance, nil)

			return
		end

		Season123PickHeroEntryController.instance:openPickSupportView(true)
	end
end

function var_0_0.OpenAnim(arg_13_0)
	gohelper.setActive(arg_13_0.viewGO, false)

	local var_13_0 = (arg_13_0._index - 1) % 4 * 0.03

	TaskDispatcher.runDelay(arg_13_0.playOpenAnim, arg_13_0, var_13_0)
end

function var_0_0.playOpenAnim(arg_14_0)
	gohelper.setActive(arg_14_0.viewGO, true)
end

function var_0_0.cutHeroAnim(arg_15_0, arg_15_1)
	gohelper.setActive(arg_15_0._gocuthero, arg_15_1)
	arg_15_0._animCuthero:Play("pickheroentryview_click", 0, 0)
end

return var_0_0

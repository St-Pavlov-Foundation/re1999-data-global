module("modules.logic.weekwalk_2.view.WeekWalk_2HeroGroupBuffView", package.seeall)

local var_0_0 = class("WeekWalk_2HeroGroupBuffView", BaseView)

function var_0_0.onInitView(arg_1_0)
	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(arg_2_0.viewContainer, HeroGroupEvent.SwitchBalance, arg_2_0._onSwitchBalance, arg_2_0)
	arg_2_0:addEventCb(arg_2_0.viewContainer, HeroGroupEvent.BeforeEnterFight, arg_2_0.beforeEnterFight, arg_2_0)
	arg_2_0:addEventCb(WeekWalk_2Controller.instance, WeekWalk_2Event.OnBuffSetupReply, arg_2_0._onBuffSetupReply, arg_2_0)
	arg_2_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.SwitchReplay, arg_2_0._switchReplay, arg_2_0)
	arg_2_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyGroupSelectIndex, arg_2_0._onModifyGroupSelectIndex, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_2_0._onOpenView, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(arg_3_0.viewContainer, HeroGroupEvent.SwitchBalance, arg_3_0._onSwitchBalance, arg_3_0)
end

function var_0_0.beforeEnterFight(arg_4_0)
	return
end

function var_0_0._onSwitchBalance(arg_5_0)
	if arg_5_0._animator then
		arg_5_0._animator:Play("switch", 0, 0)
	end
end

function var_0_0._initFairyLandCard(arg_6_0)
	arg_6_0:_loadEffect()
end

function var_0_0._loadEffect(arg_7_0)
	arg_7_0._effectUrl = "ui/viewres/weekwalk/weekwalkheart/herogroupviewweekwalkheart.prefab"
	arg_7_0._effectLoader = MultiAbLoader.New()

	arg_7_0._effectLoader:addPath(arg_7_0._effectUrl)
	arg_7_0._effectLoader:startLoad(arg_7_0._effectLoaded, arg_7_0)
end

function var_0_0._effectLoaded(arg_8_0, arg_8_1)
	local var_8_0 = gohelper.findChild(arg_8_0.viewGO, "#go_fairylandcard")

	gohelper.setActive(var_8_0, true)

	local var_8_1 = arg_8_1:getAssetItem(arg_8_0._effectUrl):GetResource(arg_8_0._effectUrl)
	local var_8_2 = gohelper.clone(var_8_1, var_8_0)

	arg_8_0._animator = var_8_2:GetComponent(typeof(UnityEngine.Animator))
	arg_8_0._goBuffNew = gohelper.findChild(var_8_2, "#go_weekwalkheart/#go_new")
	arg_8_0._goNoBuff = gohelper.findChild(var_8_2, "#go_weekwalkheart/#go_NoBuff")
	arg_8_0._goHasBuff = gohelper.findChild(var_8_2, "#go_weekwalkheart/#go_HasBuff")
	arg_8_0._buffName = gohelper.findChildText(var_8_2, "#go_weekwalkheart/#go_HasBuff/cardnamebg/#txt_buffname")
	arg_8_0._imageBuff = gohelper.findChildImage(var_8_2, "#go_weekwalkheart/#go_HasBuff/#image_buff")
	arg_8_0._btnclick = gohelper.findChildButtonWithAudio(var_8_2, "#go_weekwalkheart/#btn_click")

	arg_8_0._btnclick:AddClickListener(arg_8_0._btnclickOnClick, arg_8_0)
	arg_8_0:_initBuff()
	arg_8_0:_updateBuffNewFlag()
end

function var_0_0._updateBuffNewFlag(arg_9_0)
	local var_9_0 = WeekWalk_2Model.instance:getCurMapId()

	if not var_9_0 then
		return
	end

	if WeekWalk_2Controller.hasOnceActionKey(WeekWalk_2Enum.OnceAnimType.FightBuffNew, var_9_0) then
		return
	end

	local var_9_1 = WeekWalk_2Model.instance:getCurMapInfo()
	local var_9_2 = var_9_1.config.preId
	local var_9_3 = var_9_2 and WeekWalk_2Model.instance:getLayerInfo(var_9_2)

	if not var_9_3 then
		return
	end

	local var_9_4 = var_9_1.config.chooseSkillNum ~= var_9_3.config.chooseSkillNum

	gohelper.setActive(arg_9_0._goBuffNew, var_9_4)

	arg_9_0._showBuffNewFlag = var_9_4
end

function var_0_0._onOpenView(arg_10_0, arg_10_1)
	if arg_10_0._showBuffNewFlag and arg_10_1 == ViewName.WeekWalk_2HeartBuffView then
		arg_10_0._showBuffNewFlag = false

		gohelper.setActive(arg_10_0._goBuffNew, false)

		local var_10_0 = WeekWalk_2Model.instance:getCurMapId()

		WeekWalk_2Controller.setOnceActionKey(WeekWalk_2Enum.OnceAnimType.FightBuffNew, var_10_0)
	end
end

function var_0_0._initBuff(arg_11_0)
	arg_11_0._buffConfig = nil

	local var_11_0 = WeekWalk_2BuffListModel.getCurHeroGroupSkillId()

	if var_11_0 then
		arg_11_0._buffConfig = lua_weekwalk_ver2_skill.configDict[var_11_0]
	end

	arg_11_0:_updateDreamLandCardInfo()
end

function var_0_0._btnclickOnClick(arg_12_0)
	if arg_12_0._isReplay then
		return
	end

	WeekWalk_2Controller.instance:openWeekWalk_2HeartBuffView({
		isBattle = true
	})
end

function var_0_0._editableInitView(arg_13_0)
	arg_13_0:_initFairyLandCard()
end

function var_0_0.onOpen(arg_14_0)
	arg_14_0:_setTaskDes()
end

function var_0_0._setTaskDes(arg_15_0)
	return
end

function var_0_0._switchReplay(arg_16_0, arg_16_1)
	if not arg_16_0._taskConfig then
		return
	end

	if arg_16_0._animator then
		arg_16_0._animator:Play("switch", 0, 0)
	end

	arg_16_0._isReplay = arg_16_1

	TaskDispatcher.cancelTask(arg_16_0._doSwitchReplay, arg_16_0)

	if arg_16_0._isReplay then
		TaskDispatcher.runDelay(arg_16_0._doSwitchReplay, arg_16_0, 0.16)
	end
end

function var_0_0._doSwitchReplay(arg_17_0)
	if arg_17_0._isReplay then
		-- block empty
	end
end

function var_0_0._onModifyGroupSelectIndex(arg_18_0)
	arg_18_0:_initBuff()
end

function var_0_0._onBuffSetupReply(arg_19_0)
	arg_19_0:_initBuff()
end

function var_0_0._updateDreamLandCardInfo(arg_20_0)
	gohelper.setActive(arg_20_0._goNoBuff, false)
	gohelper.setActive(arg_20_0._goHasBuff, false)

	if not arg_20_0._buffConfig or not arg_20_0._imageBuff then
		gohelper.setActive(arg_20_0._goNoBuff, true)

		return
	end

	gohelper.setActive(arg_20_0._goHasBuff, true)

	local var_20_0 = arg_20_0._buffConfig.id
	local var_20_1 = lua_skill.configDict[var_20_0]

	arg_20_0._buffName.text = arg_20_0._buffConfig.name

	UISpriteSetMgr.instance:setWeekWalkSprite(arg_20_0._imageBuff, arg_20_0._buffConfig.icon)
end

function var_0_0.onClose(arg_21_0)
	if arg_21_0._btnclick then
		arg_21_0._btnclick:RemoveClickListener()
	end

	if arg_21_0._animator then
		arg_21_0._animator.enabled = true

		arg_21_0._animator:Play("close", 0, 0)
	end

	TaskDispatcher.cancelTask(arg_21_0._doSwitchReplay, arg_21_0)
end

function var_0_0.onDestroyView(arg_22_0)
	if arg_22_0._effectLoader then
		arg_22_0._effectLoader:dispose()
	end
end

return var_0_0

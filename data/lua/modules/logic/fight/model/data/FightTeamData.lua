module("modules.logic.fight.model.data.FightTeamData", package.seeall)

local var_0_0 = FightDataClass("FightTeamData")

function var_0_0.onConstructor(arg_1_0, arg_1_1)
	arg_1_0.entitys = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.entitys) do
		table.insert(arg_1_0.entitys, FightEntityInfoData.New(iter_1_1))
	end

	arg_1_0.subEntitys = {}

	for iter_1_2, iter_1_3 in ipairs(arg_1_1.subEntitys) do
		table.insert(arg_1_0.subEntitys, FightEntityInfoData.New(iter_1_3))
	end

	arg_1_0.power = arg_1_1.power
	arg_1_0.clothId = arg_1_1.clothId
	arg_1_0.skillInfos = {}

	for iter_1_4, iter_1_5 in ipairs(arg_1_1.skillInfos) do
		table.insert(arg_1_0.skillInfos, FightPlayerSkillInfoData.New(iter_1_5))
	end

	arg_1_0.spEntitys = {}

	for iter_1_6, iter_1_7 in ipairs(arg_1_1.spEntitys) do
		table.insert(arg_1_0.spEntitys, FightEntityInfoData.New(iter_1_7))
	end

	arg_1_0.indicators = {}

	for iter_1_8, iter_1_9 in ipairs(arg_1_1.indicators) do
		table.insert(arg_1_0.indicators, FightIndicatorInfoData.New(iter_1_9))
	end

	arg_1_0.exTeamStr = arg_1_1.exTeamStr

	if arg_1_1:HasField("assistBoss") then
		arg_1_0.assistBoss = FightEntityInfoData.New(arg_1_1.assistBoss)
	end

	if arg_1_1:HasField("assistBossInfo") then
		arg_1_0.assistBossInfo = FightAssistBossInfoData.New(arg_1_1.assistBossInfo)
	end

	if arg_1_1:HasField("emitter") then
		arg_1_0.emitter = FightEntityInfoData.New(arg_1_1.emitter)
	end

	if arg_1_1:HasField("emitterInfo") then
		arg_1_0.emitterInfo = FightEmitterInfoData.New(arg_1_1.emitterInfo)
	end

	if arg_1_1:HasField("playerEntity") then
		arg_1_0.playerEntity = FightEntityInfoData.New(arg_1_1.playerEntity)
	end

	if arg_1_1:HasField("playerFinisherInfo") then
		arg_1_0.playerFinisherInfo = FightPlayerFinisherInfoData.New(arg_1_1.playerFinisherInfo)
	end

	arg_1_0.energy = arg_1_1.energy

	if arg_1_1:HasField("cardHeat") then
		arg_1_0.cardHeat = FightCardHeatInfoData.New(arg_1_1.cardHeat)
	end

	arg_1_0.cardDeckSize = arg_1_1.cardDeckSize

	if arg_1_1:HasField("bloodPool") then
		arg_1_0.bloodPool = FightDataBloodPool.New(arg_1_1.bloodPool)
	end

	if arg_1_1:HasField("vorpalith") then
		arg_1_0.vorpalith = FightEntityInfoData.New(arg_1_1.vorpalith)
	end

	if arg_1_1:HasField("itemSkillGroup") then
		arg_1_0.itemSkillInfos = {}

		for iter_1_10, iter_1_11 in ipairs(arg_1_1.itemSkillGroup.itemSkillInfos) do
			table.insert(arg_1_0.itemSkillInfos, FightItemPlayerSkillInfoData.New(iter_1_11))
		end
	end
end

return var_0_0

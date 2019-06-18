from pgmpy.models import BayesianModel

G = BayesianModel()
G.add_edges_from([('BirthAsphyxia', 'Disease'), ('Disease', 'LVH'), ('LVH', 'LVHreport'), ('Disease', 'DuctFlow'), ('DuctFlow', 'HypDistrib'), ('HypDistrib', 'LowerBodyO2'), ('Disease', 'CardiacMixing'), ('CardiacMixing', 'HypoxiaInO2'), 
	('HypoxiaInO2', 'RUQO2'), ('Disease', 'LungParench'), ('LungParench', 'CO2'), ('CO2', 'CO2Report'), ('LungFlow', 'ChestXray'), ('ChestXray', 'XrayReport'), ('Disease', 'Sick'), ('Sick', 'Grunting'), ('Grunting', 'GruntingReport'), ('Sick', 'Age'), ('Disease', 'Age')])
print(G)
indip = G.get_independencies()
print(indip)


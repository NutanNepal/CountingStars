n = 3

def stirling_permutations(n):
    if n < 1: raise ValueError("invalid input")
    if n == 1: return [((1,1), (1,))]
    stirling_permutations_list = []
    for x, y in stirling_permutations(n-1):
        for i in range(len(x) + 1):
            stirling_permutations_list.append((x[:i] + (n,n) + x[i:], y + (i+1,)))

    return stirling_permutations_list

def park(parkingtuple):
    park = [0] * len(parkingtuple)
    for i in range(len(park)):
        pspot = parkingtuple[i] - 1
        testforpark = False
        while testforpark == False: 
            if park[pspot] == 0:
                park[pspot] = parkingtuple[i]
                testforpark = True
            else: 
                pspot = pspot + 1
    return park

def lucky_nums(pf):
    lucky_nums = []
    for x, y in enumerate(pf):
        if x + 1 == y: lucky_nums.append(y)
    return lucky_nums #gives the lucky cars

def grouped(stirling_permutations_list):
    grouped = [[] for _ in range(n)]
    for perm, insword in stirling_permutations_list:
        pf = park(perm)
        lucky_cars = lucky_nums(pf)
        valueofinsertionword = tuple([insword[i-1] for i in lucky_cars])
        grouped[len(lucky_cars) - 1].append((perm, valueofinsertionword))
    return grouped


stirling_permutations_list = stirling_permutations(n)
g = grouped(stirling_permutations_list)

fin = [{} for _ in g]
for i, triples in enumerate(g):
    for _, y, _ in triples:
        fin[i][y] = fin[i].get(y, 0) + 1
fin
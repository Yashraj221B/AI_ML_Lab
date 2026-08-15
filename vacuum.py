import random

class SimpleReflexVacuumAgent:
    def __init__(self):
        self.tiles_cleaned = 0
        self.steps_taken = 0
 
    def act(self, percept):
        """
        Condition-action rule:
        IF percept == 'Dirty' -> Suck
        IF percept == 'Clean' -> MoveOn
        """
        if percept == 1:
            self.tiles_cleaned += 1
            return "SUCK"
        else:
            return "MOVE_ON"
  
class GridEnvironment:
    """
    Represents the 3x3 floor environment.
    0 = Clean tile, 1 = Dirty tile.
    """
 
    def __init__(self, size=3):
        self.size = size
        self.grid = [[random.randint(0, 1) for _ in range(size)] for _ in range(size)]
 
    def display(self, title="Floor State"):
        print(title)
        for row in self.grid:
            print(row)
        print()
 
    def get_percept(self, r, c):
        return self.grid[r][c]
 
    def clean_tile(self, r, c):
        self.grid[r][c] = 0
 
    def is_spotless(self):
        return all(cell == 0 for row in self.grid for cell in row)
 
    def column_major_order(self):
        for c in range(self.size):
            for r in range(self.size):
                yield (r, c)
 
 
def run_simulation():
    env = GridEnvironment(size=3)
    agent = SimpleReflexVacuumAgent()
 
    env.display("Initial Floor State (0 = Clean, 1 = Dirty)")
 
    print("Agent starts scanning column-by-column...\n")
 
    for step_number, (r, c) in enumerate(env.column_major_order(), start=1):
        percept = env.get_percept(r, c)
        print(f"Step {step_number}: Agent at tile ({r},{c}) | Percept = {percept}")
 
        action = agent.act(percept)
 
        if action == "SUCK":
            env.clean_tile(r, c)
            print("  -> Action: SUCK (tile was dirty, now cleaned)")
        else:
            print("  -> Action: MOVE_ON (tile already clean)")
 
        agent.steps_taken += 1
        print()
 
    env.display("Final Floor State")
 
    print("Performance Report")
    print("-------------------")
    print("Tiles Cleaned :", agent.tiles_cleaned)
    print("Total Tiles Visited :", agent.steps_taken)
 
    if env.is_spotless():
        print("Result: Floor is completely clean.")
    else:
        print("Result: Floor still has dirty tiles.")
 
 
if __name__ == "__main__":
    run_simulation()

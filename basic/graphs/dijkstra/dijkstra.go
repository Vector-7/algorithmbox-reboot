package main
/*
	input data (In Txt)
	Vertex size, Edge size, Starts, Ends, Values, Expected Result

	input data for algorithm function
	vertexSize int, edgeSize int, edges [][3]int, Expected Result []int
*/

import (
	"bufio"
	"os"
	"strconv"
	"strings"
	"fmt"
)

/* 파일에서 데이터 불러오기 */
func getDataFromFile(fileName string) (
		vSize			[]int,
		eSize			[]int,
		edges			[][][3]int,
		expectedResults	[][]int ) {
	
	vSize = []int{}
	eSize = []int{}
	edges = [][][3]int{}
	expectedResults = [][]int{}

	f, _ := os.Open(fileName)
	lines := make([]string, 0)
	sc := bufio.NewScanner(f)

	for sc.Scan() {
		lines = append(lines, sc.Text())
	}

	// Init result Datas

	var i int = 0
	for i < len(lines) {
		/*
			1:	Vertex Size
			2:	Edge Size
			3:	Start Vertex
			4:	End Vertex
			5:	Edge Weight
			6:	Expected Result
		*/
		vertexSize, _	:= strconv.Atoi(lines[i])
		edgeSize, _ 	:= strconv.Atoi(lines[i+1])

		var starts []string		= strings.Split(lines[i+2], " ")
		var ends []string		= strings.Split(lines[i+3], " ")
		var weights []string	= strings.Split(lines[i+4], " ")
		
		var rawExpectedResults []string = strings.Split(lines[i+5], " ")

		// parse data
		var edgeList [][3]int = [][3]int{}
		var resultList []int = []int{}

		// parse edges
		for j := 0; j < edgeSize; j++ {
			_start, _	:= strconv.Atoi(starts[j])
			_end, _		:= strconv.Atoi(ends[j])
			_weights, _	:= strconv.Atoi(weights[j])

			var _edge [3]int = [3]int{ _start, _end, _weights }
			edgeList = append(edgeList, _edge)
		}

		// parse result
		for j := 0; j < vertexSize; j++ {
			r, _ := strconv.Atoi(rawExpectedResults[j])
			resultList = append(resultList, r)
		}

		vSize = append(vSize, vertexSize)
		eSize = append(eSize, edgeSize)
		edges = append(edges, edgeList)
		expectedResults = append(expectedResults, resultList)
		i += 6
	}
	return
	
}

/* Queue Functions */
type GraphQueue struct {
	// BFS 탐색에 사용될 큐
	q [][2]int
	length int
}
func initGraphQueue() *GraphQueue {
	q := GraphQueue{[][2]int{}, 0}
	return &q
}
func (q GraphQueue) isEmpty() bool {
	return q.length == 0
}
func (q *GraphQueue) push(vertex int, totalWeight int) {
	data := [2]int{vertex, totalWeight}
	if q.q == nil {
		q.q = [][2]int{data}
	} else {
		q.q = append([][2]int{data}, q.q...)
	}
	q.length++
}
func (q *GraphQueue) pop() (vertex int, totalWeight int, isEmpty bool) {

	isEmpty = false
	vertex = -1
	totalWeight = 1

	if q.length < 1 {
		// Not Found
		isEmpty = true
		q.length = 0
	} else {
		// Found
		poped := q.q[q.length - 1]

		vertex = poped[0]
		totalWeight = poped[1]

		q.q = q.q[:q.length]
		q.length--
	}
	return
}

/* MAIN ALGORITHM */
func dijkstra(vSize int, eSize int, edges [][3]int) (result []int) {
	// edges -> [start, end, weight]

	/* MODULAR FUNCTIONS */

	// 최소 거리를 전부다 -1로 초기화
	initResult := func(size int) []int {
		var r []int = []int{}
		for i := 0; i <= size; i++ { r = append(r, -1) }
		return r
	}

	// Graph 생성
	// key: 시작 지점, value [[끝지점1, weight1], ...]
	makeGraph := func(eSize int, edges [][3]int) (graph map[int][][2]int) {

		graph = make(map[int][][2]int)
		
		appendValue := func(g map[int][][2]int, k int, v [2]int) {
			// 그래프에 데이터 추가하는 익명함수
			_, exists := g[k]
			// Key가 존재하는 지 체크
			if !exists {
				// 존재하지 않으면 리스트 생성
				g[k] = [][2]int{v}
			} else {
				// 있으면 기존 리스트에 데이터 추가
				g[k] = append(g[k], v)
			}
		}
		for i := 0; i < eSize; i++ {

			start := edges[i][0]
			end := edges[i][1]
			weight := edges[i][2]

			appendValue(graph, start, [2]int{end, weight})
			appendValue(graph, end, [2]int{start, weight})
		}
		return
	}
	
	// 비용 갱신
	updateTotalWeight := func(result []int, point int, weight int) (aleadyVisited bool) {
		switch {
		case result[point] == -1:
			// 초기값
			result[point] = weight
			aleadyVisited = false
		default:
			if result[point] > weight {
				result[point] = weight
			}
			aleadyVisited = true
		}
		return
	}

	/* MAIN PROCESS */
	__result := initResult(vSize)
	var graph map[int][][2]int = makeGraph(eSize, edges)
	Q := initGraphQueue()
	Q.push(1, 0)

	for !Q.isEmpty() {
		v, tw, _ := Q.pop()
		// vertex, total weight
		isAleadyVisited := updateTotalWeight(__result, v, tw)

		// Find End Point
		if !isAleadyVisited {
			// Is First Visit
			ends, exists := graph[v]
			// Find Next Root
			if exists {
				for i := 0; i < len(ends); i++ {
					Q.push(ends[i][0], tw + ends[i][1])
				}
			}
		}
	}
	result = __result[1:]
	return
}

/* CHECK RESULT */
func checkCase(caseNum int, size int, expected []int, actual []int) {

	printArray := func(size int, arr []int) {
		print("[ ")
		for i := 0; i < size; i++ {
			print(arr[i])
			print(", ")
		}
		print("]")
	}

	var isFailed bool = true
	for i := 0; i < size; i++ {
		if expected[i] != actual[i] {
			// Failed
			isFailed = false
			break
		}
	}
	fmt.Printf("[%d] CHECK RESULT::", caseNum)
	if !isFailed {
		println("FAILED")
		print("Expected: ")
		printArray(size, expected)
		println("")
		print("Actual: ")
		printArray(size, actual)
		println("")
	} else {
		println("SUCCESS")
	}
	println("")
}

func main() {
	vSizes, eSizes, edges, results := getDataFromFile("case.txt")
	
	for i := 0; i < len(vSizes); i++ {
		checkCase(i, vSizes[i], results[i], dijkstra(vSizes[i], eSizes[i], edges[i]))
	}
}
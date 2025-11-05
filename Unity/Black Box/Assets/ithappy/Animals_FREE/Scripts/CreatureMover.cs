[SerializeField]
private Vector3[] m_Waypoints = new Vector3[]
{
    new Vector3(0, 0, 0),
    new Vector3(5, 0, 5),
    new Vector3(10, 0, 0),
    new Vector3(5, 0, -5),
    new Vector3(0, 0, 0)
};

[SerializeField]
private float m_PointTolerance = 0.5f;

private int m_CurrentWaypoint = 0;
private bool m_AutoMove = true;

private void LateUpdate()
{
    if (!m_AutoMove || m_Waypoints.Length == 0) return;

    Vector3 targetPos = m_Waypoints[m_CurrentWaypoint];
    Vector3 dir = (targetPos - m_Transform.position);
    dir.y = 0f; // mantener en plano horizontal

    if (dir.magnitude < m_PointTolerance)
    {
        m_CurrentWaypoint = (m_CurrentWaypoint + 1) % m_Waypoints.Length;
        return;
    }

    // Convertimos la dirección a input para el CreatureMover
    Vector2 input = new Vector2(0f, 1f); // siempre hacia adelante
    bool run = true;

    // Le decimos a CreatureMover hacia dónde mirar y moverse
    SetInput(in input, in targetPos, in run, in false);
}
